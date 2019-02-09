date
set_host_options -max_cores 8
#set compile_seqmap_propagate_constants     false
#set compile_seqmap_propagate_high_effort   false
#set compile_enable_register_merging        false
#set write_sdc_output_net_resistance        false
set timing_separate_clock_gating_group     true

set search_path [concat * $search_path]

define_design_lib WORK -path ./work
  set target_library [list ~/Tools/NangateOpenCellLibrary.db]
  set link_library [list ~/Tools/NangateOpenCellLibrary.db]


  #analyze -library WORK -format sverilog ./basename.v
  analyze -library WORK -format sverilog ./encname.v
  elaborate encname
date
	
  ##because .bench file supports only these
  set_dont_use [get_lib_cells NangateOpenCellLibrary/*]
  set_attribute [get_lib_cells NangateOpenCellLibrary/NAND2_*] dont_use false
  set_attribute [get_lib_cells NangateOpenCellLibrary/AND2_*] dont_use false
  set_attribute [get_lib_cells NangateOpenCellLibrary/NOR2_*] dont_use false
  set_attribute [get_lib_cells NangateOpenCellLibrary/OR2_*] dont_use false
  set_attribute [get_lib_cells NangateOpenCellLibrary/XOR2_*] dont_use false
  set_attribute [get_lib_cells NangateOpenCellLibrary/XNOR2_*] dont_use false
  set_attribute [get_lib_cells NangateOpenCellLibrary/INV_*] dont_use false
  set_attribute [get_lib_cells NangateOpenCellLibrary/BUF*] dont_use false
 
  #compile_ultra -exact_map -no_autoungroup -no_seq_output_inversion -no_boundary_optimization

  set_wire_load_model -name Medium
  set_max_area 0

  create_clock -name VCLK -period 10  -waveform {0 5}
  set input_ports  [all_inputs]
  set output_ports [all_outputs]

  set_input_delay -max 1 [get_ports $input_ports ] -clock VCLK
  set_input_delay -min 0 [get_ports $input_ports ] -clock VCLK

  set_output_delay -max 2 [get_ports $output_ports ] -clock VCLK
  set_output_delay -min 1 [get_ports $output_ports ] -clock VCLK

date
  #compile  -autoungroup area
  ungroup -flatten -all
  compile -exact_map -ungroup_all -auto_ungroup area
  #compile_ultra ;#-ungroup_all
#date
  #compile_ultra  -incremental
#date
change_name -rules verilog -hierarchy
set bus_naming_style "%s_%d"
define_name_rules verilog -target_bus_naming_style "%s_%d"
change_names -rules verilog -hier

report_timing -nworst 10 -max_paths 20 -nosplit -input_pins -nets -capacitance  >         encname.rpt
report_area                                        > ./encname_area.rpt
report_design -nosplit                             > ./encname_design.rpt
report_constraint -all_violators -nosplit -verbose > ./encname_constraint.rpt
check_design -nosplit                              > ./encname_design.rpt
report_power -analysis_effort high                 > ./encname_power.rpt
report_qor                                         > ./encname_qor.rpt

write -format verilog -hierarchy -output encname_RTL.v 
#write -format verilog -hierarchy -output encname.v 
write_sdc encname.sdc

exit
