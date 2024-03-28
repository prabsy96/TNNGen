#### Template Script for RTL->Gate-Level Flow (generated from GENUS 18.14-s037_1) 
if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################

set DESIGN $DESIGN
set GEN_EFF high
set MAP_OPT_EFF high

# Set Other Params
set DATE [clock format [clock seconds] -format "%b%d-%T"] 	
set _OUTPUTS_PATH $HOME_DIR/syn_out/${DESIGN}/out/							
set _REPORTS_PATH $HOME_DIR/syn_out/${DESIGN}/rep/
set _INTER_PATH $HOME_DIR/syn_out/${DESIGN}/inter/										
set _LOG_PATH $HOME_DIR/syn_out/${DESIGN}/log/
##set ET_WORKDIR <ET work directory>

# Start actual Genus Operations
set_db / .init_lib_search_path {${LIB_PATH}}		                                          
set_db / .script_search_path {$HOME_DIR/templates/}								        
set_db / .init_hdl_search_path {${RTL_PATH}} 
##Uncomment and specify machine names to enable super-threading.
#set_db / .super_thread_servers {<machine names>} 
##For design size of 1.5M - 5M gates, use 8 to 16 CPUs. For designs > 5M gates, use 16 to 32 CPUs
set_db / .max_cpus_per_server 16

##Default undriven/unconnected setting is 'none'.  
#set_db / .hdl_unconnected_value 0 | 1 | x | none
set_db / .information_level 7 
set_db auto_ungroup none


###############################################################
## Library setup
###############################################################

read_libs " \
${LIB_PATH}asap7sc7p5t_AO_RVT_TT_ccs_201020.lib \
${LIB_PATH}asap7sc7p5t_INVBUF_RVT_TT_ccs_201020.lib \
${LIB_PATH}asap7sc7p5t_OA_RVT_TT_ccs_201020.lib\
${LIB_PATH}asap7sc7p5t_SEQ_RVT_TT_ccs_201020.lib \
${LIB_PATH}asap7sc7p5t_SIMPLE_RVT_TT_ccs_201020.lib \
${LIB_PATH}flogic_8x1_tt_0.7_25_ccs.lib \
${LIB_PATH}fsm_output_tt_0.7_25_ccs.lib \
${LIB_PATH}add_inv_tt_0.7_25_ccs.lib \
${LIB_PATH}fsm_simple_macro_tt_0.7_25_ccs.lib \
${LIB_PATH}fsm_weight_incdec_tt_0.7_25_ccs.lib \

${LIB_PATH}incdec_mod_tt_0.7_25_ccs.lib \
${LIB_PATH}inhibit_pass_tt_0.7_25_ccs.lib \
${LIB_PATH}pulse2edge_area_tt_0.7_25_ccs.lib \
${LIB_PATH}stdp_tt_0.7_25_ccs.lib \
"

read_physical -lef " \
${LEF_PATH}asap7_tech_4x_201209.lef \
${LEF_PATH}asap7sc7p5t_27_R_4x_201211.lef \
${LEF_PATH}add_inv.lef \
${LEF_PATH}flogic_8x1_new.lef \
${LEF_PATH}fsm_output.lef \
${LEF_PATH}fsm_simple_macro.lef \
${LEF_PATH}fsm_weight_incdec.lef \
${LEF_PATH}fsm_weight_update.lef \
${LEF_PATH}incdec_mod.lef \
${LEF_PATH}inhibit_pass.lef \
${LEF_PATH}pulse2edge_area.lef \
${LEF_PATH}stdp_cases.lef \
"

read_qrc ${LIB_PATH}qrcTechFile_typ03_scaled4xV06
set_db / .hdl_generate_index_style %s_%d_
set_db / .lp_insert_clock_gating false
set_db / .hdl_flatten_complex_port false
#set_db / .hdl_track_filename_row_col true 
#set_db lp_power_unit uW 

####################################################################
## Load Design
####################################################################

read_hdl "$RTL_PATH/$DESIGN.v"
# set hdl_unconnected_value 0

elaborate $DESIGN

puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration
check_design -unresolved

####################################################################
## Constraints Setup
####################################################################
create_clock [get_ports clk]  -period $ACLKP -name clk
#create_clock [get_ports gclk]  -period $GCLKP -name gclk

set_clock_uncertainty 100 [get_clocks clk]
set_clock_transition -fall 150 [get_clocks clk]
set_clock_transition -rise 150 [get_clocks clk]
#set_clock_uncertainty 100 [get_clocks gclk]
#set_clock_transition -fall 150 [get_clocks gclk]
#set_clock_transition -rise 150 [get_clocks gclk]

#set_input_delay 2000 -clock clk [remove_from_collection [all_inputs] clk]
set_output_delay 2000 -clock clk [all_outputs]
#set_load 15 [all_outputs]

puts "The number of exceptions is [llength [vfind "design:$DESIGN" -exception *]]"
#set_db "design:$DESIGN" .force_wireload <wireload name> 

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_LOG_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}

if {![file exists ${_INTER_PATH}]} {
  file mkdir ${_INTER_PATH}
  puts "Creating directory ${_INTER_PATH}"
}

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_LOG_PATH}"
}

check_timing_intent

###################################################################################
## Define cost groups (clock-clock, clock-output, input-clock, input-output)
###################################################################################

## Uncomment to remove already existing costgroups before creating new ones.
## delete_obj [vfind /designs/* -cost_group *]
if {[llength [all_registers]] > 0} { 
  define_cost_group -name I2C -design $DESIGN
  define_cost_group -name C2O -design $DESIGN
  define_cost_group -name C2C -design $DESIGN
  path_group -from [all_registers] -to [all_registers] -group C2C -name C2C
  path_group -from [all_registers] -to [all_outputs] -group C2O -name C2O
  path_group -from [all_inputs]  -to [all_registers] -group I2C -name I2C
}

define_cost_group -name I2O -design $DESIGN
path_group -from [all_inputs]  -to [all_outputs] -group I2O -name I2O
foreach cg [vfind / -cost_group *] {
  report_timing -group [list $cg] >> $_INTER_PATH/${DESIGN}_pretim.rpt
}

####################################################################
## Annotate Switching
####################################################################
#read_vcd $vcd_file -vcd_scope column_tb/DUT



####################################################################################################
## Synthesizing to generic 
####################################################################################################
set_db / .syn_generic_effort $GEN_EFF
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC

# ####################################################################################################
# ## Synthesizing to gates
# ####################################################################################################
 set_db / .syn_map_effort $MAP_OPT_EFF
 syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED



#######################################################################################################
## Optimize Netlist
#######################################################################################################
set_db / .syn_opt_effort $MAP_OPT_EFF
syn_opt 
puts "Runtime & Memory after 'syn_opt'"
time_info OPT

######################################################################################################
## write backend file set (verilog, SDC, config, etc.)
######################################################################################################
report_power > $_REPORTS_PATH/${DESIGN}_power.rpt
report_timing -unconstrained > $_REPORTS_PATH/${DESIGN}_time.rpt
report_area > $_REPORTS_PATH/${DESIGN}_area.rpt
write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_m.v
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_m.sdc
write_sdf -timescale ns -precision 3 > ${_OUTPUTS_PATH}/${DESIGN}_m.sdf
#read_vcd $vcd_file -vcd_scope column_tb/DUT
#Uncomment the below if you want more detailed reports
report_dp > $_REPORTS_PATH/${DESIGN}_datapath_incr.rpt
write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -directory $_REPORTS_PATH

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

file copy [get_db / .stdout_log] ${_LOG_PATH}/.
quit
