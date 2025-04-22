# scripts/place_icc2.tcl

set DESIGN_NAME stop_watch
open_lib ${DESIGN_NAME}_LIB
copy_block floorplan_done placement_block
current_block placement_block

# Placement optimization options
set place_opt.initial_place.effort high
set place_opt.flow.enable_multibit_banking true 
set place_opt.initial_place.buffering_aware true
set place_opt.initial_drc.global_route_based true

# Perform placement
place_opt -from initial_drc -to initial_opto
place_opt -from final_place

# Reports
report_qor > reports/${DESIGN_NAME}_qor_final_place.rpt
report_timing > reports/${DESIGN_NAME}_timing_final_place.rpt
report_power > reports/${DESIGN_NAME}_power_final_place.rpt
report_congestion > reports/${DESIGN_NAME}_congestion_final_place.rpt

save_block -as placement_done

