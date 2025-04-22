# scripts/floorplan.tcl
set design_name "simple_adder"
set top_module "simple_adder"

read_verilog ../design/${design_name}.v
set_top_module $top_module

create_mw_lib -technology /path/to/tech.lef -mw_reference_libs /path/to/lib -mw_design_lib ./mw/${design_name}

open_mw_lib ./mw/${design_name}
create_cell $design_name

floorPlan -coreUtil 0.7 -coreMarginsBy die -site core

save_mw_cel -as floorplan_done

