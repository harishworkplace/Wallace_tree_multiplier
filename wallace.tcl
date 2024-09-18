set_db init_lib_search_path /home/installs/FOUNDRY/digital/90nm/dig/lib  
set_db hdl_search_path /home/cadence/Desktop/114/wallace_tree

set_db library slow.lib
read_hdl wallace.v
elaborate
read_sdc /home/cadence/Desktop/114/wallace_tree/wallace.sdc
set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt


write_hdl > wallace_netlist.v
write_sdc > wallace_block.sdc
report_area > wallace_area.rep
report_gates > wallace_gate.rep
report_power > wallace_power.rep
report_timing > wallace_timing.rep
gui_show
