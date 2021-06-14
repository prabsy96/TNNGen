#### Template Script for RTL->Gate-Level Flow (generated from GENUS 18.14-s037_1) 

if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}

puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################


set DESIGN incdec
set GEN_EFF high
set MAP_OPT_EFF high
set DATE [clock format [clock seconds] -format "%b%d-%T"] 
set _OUTPUTS_PATH /afs/ece.cmu.edu/usr/pvellais/Private/RA_work/7nm_optimizations/final_set/incdec/optimized/outputs_incdec
set _REPORTS_PATH /afs/ece.cmu.edu/usr/pvellais/Private/RA_work/7nm_optimizations/final_set/incdec/optimized/report_incdec
set _LOG_PATH logs_${DATE}
# set _OUTPUTS_PATH ../outputs
# set _REPORTS_PATH ../reports
set _LOG_PATH logs
##set ET_WORKDIR <ET work directory>
set_db / .init_lib_search_path {/afs/ece.cmu.edu/usr/pvellais/Private/RA_work/7nm_optimizations/final_set/MASTER/lib/}
set_db / .script_search_path {/afs/ece.cmu.edu/usr/pvellais/Private/RA_work/7nm_optimizations/final_set/MASTER/syn_tcl}
set_db / .init_hdl_search_path {/afs/ece.cmu.edu/usr/pvellais/Private/RA_work/7nm_optimizations/final_set/MASTER/rtl/src} 
##Uncomment and specify machine names to enable super-threading.
##set_db / .super_thread_servers {<machine names>} 
##For design size of 1.5M - 5M gates, use 8 to 16 CPUs. For designs > 5M gates, use 16 to 32 CPUs
##set_db / .max_cpus_per_server 8

##Default undriven/unconnected setting is 'none'.  
##set_db / .hdl_unconnected_value 0 | 1 | x | none

set_db / .information_level 7 

set_db auto_ungroup none

###############################################################
## Library setup
###############################################################


read_libs " \
    /afs/ece.cmu.edu/usr/pvellais/Private/ASAP7/ASAP7_PDKandLIB_v1p6/lib_release_191006/asap7_7p5t_library/rev25/LIB/CCS/asap7sc7p5t_SIMPLE_RVT_TT_ccs_191031.lib \
    /afs/ece.cmu.edu/usr/pvellais/Private/ASAP7/ASAP7_PDKandLIB_v1p6/lib_release_191006/asap7_7p5t_library/rev25/LIB/CCS/asap7sc7p5t_SEQ_RVT_TT_ccs_191031.lib \
    /afs/ece.cmu.edu/usr/pvellais/Private/ASAP7/ASAP7_PDKandLIB_v1p6/lib_release_191006/asap7_7p5t_library/rev25/LIB/CCS/asap7sc7p5t_OA_RVT_TT_ccs_191031.lib \
    /afs/ece.cmu.edu/usr/pvellais/Private/ASAP7/ASAP7_PDKandLIB_v1p6/lib_release_191006/asap7_7p5t_library/rev25/LIB/CCS/asap7sc7p5t_INVBUF_RVT_TT_ccs_191031.lib \
    /afs/ece.cmu.edu/usr/pvellais/Private/ASAP7/ASAP7_PDKandLIB_v1p6/lib_release_191006/asap7_7p5t_library/rev25/LIB/CCS/asap7sc7p5t_AO_RVT_TT_ccs_191031.lib \
flogic_8x1_tt_0.7_25_ccs.lib \
fsm_output_tt_0.7_25_ccs.lib \
add_inv_tt_0.7_25_ccs.lib \
fsm_simple_macro_tt_0.7_25_ccs.lib \
fsm_weight_incdec_tt_0.7_25_ccs.lib \
fsm_weight_update_tt_0.7_25_ccs.lib \
incdec_mod_tt_0.7_25_ccs.lib \
inhibit_pass_tt_0.7_25_ccs.lib \
pulse2edge_area_tt_0.7_25_ccs.lib \
stdp_tt_0.7_25_ccs.lib \
"

# read_libs " \
#   /afs/ece.cmu.edu/usr/sbhasuth/project_neuromorphic/asap7_7p5t_library/rev25/LIB/NLDM/asap7sc7p5t_SIMPLE_RVT_TT_08302018.lib.gz \
#   /afs/ece.cmu.edu/usr/sbhasuth/project_neuromorphic/asap7_7p5t_library/rev25/LIB/NLDM/asap7sc7p5t_INVBUF_RVT_TT_08302018.lib.gz \
#   /afs/ece.cmu.edu/usr/sbhasuth/project_neuromorphic/asap7_7p5t_library/rev25/LIB/NLDM/asap7sc7p5t_SEQ_RVT_TT_08302018.lib.gz \
#   /afs/ece.cmu.edu/usr/sbhasuth/lib/lib/mux_tt_0.7_25_ccs.lib \
# "
# read_physical -lef " \
#     /afs/ece.cmu.edu/usr/sbhasuth/project_neuromorphic/asap7_7p5t_library/rev25/LEF/asap7_tech_4x_181009.lef \
#     /afs/ece.cmu.edu/usr/sbhasuth/project_neuromorphic/asap7_7p5t_library/rev25/LEF/asap7sc7p5t_24_R_4x_170912.lef \
# 	/afs/ece.cmu.edu/usr/sbhasuth/virtuoso_test/MUX2x1_4x.lef \
# "
# 
read_physical -lef " \
  /afs/ece.cmu.edu/usr/pvellais/Private/ASAP7/ASAP7_PDKandLIB_v1p6/lib_release_191006/asap7_7p5t_library/rev25/LEF/asap7_tech_4x_181009.lef \
  /afs/ece.cmu.edu/usr/pvellais/Private/ASAP7/ASAP7_PDKandLIB_v1p6/lib_release_191006/asap7_7p5t_library/rev25/LEF/asap7sc7p5t_24_R_4x_170912.lef \
add_inv.lef \
flogic_8x1_new.lef \
fsm_output.lef \
fsm_simple_macro.lef \
fsm_weight_incdec.lef \
fsm_weight_update.lef \
incdec_mod.lef \
inhibit_pass.lef \
pulse2edge_area.lef \
stdp_cases.lef \
"

## Provide either cap_table_file or the qrc_tech_file
#set_db / .cap_table_file <file> 
read_qrc /afs/ece.cmu.edu/usr/pvellais/Private/ASAP7/ASAP7_PDKandLIB_v1p6/lib_release_191006/asap7_7p5t_library/rev25/qrc/qrcTechFile_typ03_scaled4xV06
##generates <signal>_reg[<bit_width>] format
#set_db / .hdl_array_naming_style %s\[%d\] 
## 

set_db / .hdl_generate_index_style %s_%d_

set_db / .lp_insert_clock_gating true 

####################################################################
## Load Design
####################################################################


read_hdl -language sv "incdec.sv "
elaborate $DESIGN
puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration



check_design -unresolved

####################################################################
## Constraints Setup
####################################################################

read_sdc chip.sdc
puts "The number of exceptions is [llength [vfind "design:$DESIGN" -exception *]]"


#set_db "design:$DESIGN" .force_wireload <wireload name> 

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_LOG_PATH}"
}

if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
  puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
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
  report_timing -group [list $cg] >> $_REPORTS_PATH/${DESIGN}_pretim.rpt
}


#### To turn off sequential merging on the design 
#### uncomment & use the following attributes.
##set_db / .optimize_merge_flops false 
##set_db / .optimize_merge_latches false 
#### For a particular instance use attribute 'optimize_merge_seqs' to turn off sequential merging. 



####################################################################################################
## Synthesizing to generic 
####################################################################################################

set_db / .syn_generic_effort $GEN_EFF
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
report_dp > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH





####################################################################################################
## Synthesizing to gates
####################################################################################################


# set_db / .syn_map_effort $MAP_OPT_EFF
# syn_map
# puts "Runtime & Memory after 'syn_map'"
# time_info MAPPED
# write_snapshot -outdir $_REPORTS_PATH -tag map
# report_summary -directory $_REPORTS_PATH
# report_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt


# foreach cg [vfind / -cost_group *] {
  # report_timing -group [list $cg] > $_REPORTS_PATH/${DESIGN}_[vbasename $cg]_post_map.rpt
# }


# write_do_lec -revised_design fv_map -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate.lec.do

## ungroup -threshold <value>

#######################################################################################################
## Optimize Netlist
#######################################################################################################

## Uncomment to remove assigns & insert tiehilo cells during Incremental synthesis
##set_db / .remove_assigns true 
##set_remove_assign_options -buffer_or_inverter <libcell> -design <design|subdesign> 
##set_db / .use_tiehilo_for_const <none|duplicate|unique> 
set_db / .syn_opt_effort $MAP_OPT_EFF
syn_opt 
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH

puts "Runtime & Memory after 'syn_opt'"
time_info OPT

foreach cg [vfind / -cost_group *] {
  report_timing -group [list $cg] > $_REPORTS_PATH/${DESIGN}_[vbasename $cg]_post_opt.rpt
}



######################################################################################################
## write backend file set (verilog, SDC, config, etc.)
######################################################################################################



report_dp > $_REPORTS_PATH/${DESIGN}_datapath_incr.rpt
report_timing -unconstrained > $_REPORTS_PATH/${DESIGN}_timing.rpt
report_power > $_REPORTS_PATH/${DESIGN}_power.rpt
report_messages > $_REPORTS_PATH/${DESIGN}_messages.rpt
write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -directory $_REPORTS_PATH
write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_m.v
write_script > ${_OUTPUTS_PATH}/${DESIGN}_m.script
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_m.sdc

write_sdf -timescale ns -precision 3 > ${_OUTPUTS_PATH}/${DESIGN}_m.sdf


#################################
### write_do_lec
#################################


#write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do
##Uncomment if the RTL is to be compared with the final netlist..
#write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

file copy [get_db / .stdout_log] ${_LOG_PATH}/.
suspend
quit
