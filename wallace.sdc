set_input_transition 0.12 [all_inputs]
set_input_delay -max 0.8 [get_ports "a"]
set_input_delay -max 0.8 [get_ports "b"] 
set_output_delay -max 0.8 [get_ports "out"] 
set_load 0.15 [all_outputs]
set_max_fanout 20.00 [current_design]
