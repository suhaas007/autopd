# scripts/floorplan_icc2.tcl

set DESIGN_NAME stop_watch
set MW_TECH_FILE               /home/vlsilab2/TSMCHOME/Executable_Package/Collaterals/Tech/APR/N16ADFP_APR_ICC2/N16ADFP_APR_ICC2_11M.10a.tf 
set MW_POWER_NET               "VDD"
set MW_GROUND_NET              "VSS"

# Clean up any existing block
if {[file exists $DESIGN_NAME]} {
  file delete -force $DESIGN_NAME
}
if {[file exists ${DESIGN_NAME}_LIB]} {
  file delete -force ${DESIGN_NAME}_LIB
}

# Setup lib
set ref_lib [glob ndms/*.ndm]
create_lib $DESIGN_NAME -technology $MW_TECH_FILE -ref_libs $ref_lib
read_verilog -top full_chip_$DESIGN_NAME ./inputs/${DESIGN_NAME}_syn.vg
current_block full_chip_${DESIGN_NAME}
link_block

# Read constraints
read_sdc ./inputs/${DESIGN_NAME}_syn.sdc

# Floorplan
initialize_floorplan -boundary { {0 0} {0 1600} {1600 1600} {1600 0} } \
    -core_offset {120 120 120 120} -core_utilization 0.8 \
    -control_type die -honor_pad_limit -use_site_row

# IO + Power Plan
source scripts/IO_pads.tcl
source scripts/power_planning.tcl

# Optional Scan DEF
if {[file exists ./inputs/${DESIGN_NAME}_syn.scan.def]} {
  read_def ./inputs/${DESIGN_NAME}_syn.scan.def
}

save_block -as floorplan_done

