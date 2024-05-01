# Place-and-route using Cadence Innovus
# - using ASAP7 + TNN7
# Authors: Prabhu Vellaisamy, Harideep Nair
# Last modified by: YoungSeok Na

puts "====================================================="
puts " INIT "
puts "====================================================="

setLibraryUnit -cap 1fF
setLibraryUnit -time 1ps

global init_verilog
global init_lef_file
global init_top_cell
global init_mmmc_file
global init_gnd_net
global init_pwr_net

set init_verilog   $RTL_PATH
set init_mmmc_file $MMMC_FILE
set init_lef_file  " \
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
set init_top_cell  $DESIGN
set init_gnd_net   "VSS"
set init_pwr_net   "VDD"

init_design
# AAE-SI Optimization can only be turned on when the timing analysis mode is set to OCV.
setAnalysisMode -analysisType onChipVariation
setDesignMode -process 7

create_rc_corner -name typical \
    -T 25 \
    -preRoute_res 1.00 \
    -preRoute_cap 1.00 \
    -postRoute_res 1.00 \
    -postRoute_cap 1.00 \
    -postRoute_xcap 1.00

create_library_set -name libs_typical \
    -timing $LIB_PATH

create_delay_corner -name delay_default \
   -early_library_set libs_typical \
   -late_library_set libs_typical \
   -rc_corner typical

create_constraint_mode -name constraints_default \
   -sdc_files [list ${HOME_DIR}/templates/constraints.sdc]

create_analysis_view -name analysis_default \
   -constraint_mode constraints_default \
   -delay_corner delay_default

set_analysis_view \
   -setup [list analysis_default] \
   -hold [list analysis_default]


# timeDesign -preplace -prefix preplace
# checkDesign -all
# check_timing

puts "====================================================="
puts " PLACE "
puts "====================================================="
# setPlaceMode -place_global_place_io_pins false
# add_tracks -honor_pitch
# clearGlobalNets
set fpxdim 8000
set fpydim 8000

floorPlan -r 1.0 0.70 4.0 4.0 4.0 4.0
puts "Floorplan is $fpxdim by $fpydim"
puts "Total area is [expr $fpxdim * $fpydim ] square um"

globalNetConnect VDD -type pgpin -pin VDD -inst * -verbose
globalNetConnect VSS -type pgpin -pin VSS -inst * -verbose

sroute -nets {VDD VSS}

addRing -nets {VDD VSS} -width 0.6 -spacing 0.5 \
            -layer [list top 7 bottom 7 left 6 right 6]

addStripe -nets {VSS VDD} -layer 6 -direction vertical \
            -width 0.4 -spacing 0.5 -set_to_set_distance 5 -start 0.5

addStripe -nets {VSS VDD} -layer 7 -direction horizontal \
            -width 0.4 -spacing 0.5 -set_to_set_distance 5 -start 0.5

# createBasicPathGroups
setMaxRouteLayer 6
# report_clocks

# setOptMode -usefulSkew false \
#     -allEndPoints true \
#     -fixHoldAllowSetupTnsDegrade false

placeDesign

assignIoPins -pin *

# report_timing

# optDesign -preCTS
# optDesign -incremental

# setPlaceMode -place_global_place_io_pins true
place_opt_design -prefix place

puts "====================================================="
puts " CTS "
puts "====================================================="
ccopt_design
# setNanoRouteMode -drouteMinimizeLithoEffectOnLayer {f t t t t t t t t t} \
#     -routeTopRoutingLayer 5 -routeBottomRoutingLayer 2 \
#     -routeWithViaInPin true

puts "====================================================="
puts " POST_CTS "
puts "====================================================="
setOptMode -holdFixingCells {BUF_X1}
optDesign -postCTS -outDir timingReports -prefix postCTS_hold -hold

# optDesign -postCTS -hold -prefix postcts_hold

puts "====================================================="
puts " ROUTE "
puts "====================================================="
routeDesign
optDesign -postRoute -outDir timingReports -prefix postRoute_hold -hold

puts "====================================================="
puts " POSTROUTE "
puts "====================================================="
setFillerMode -corePrefix FILL -core "FILLCELL_X4 FILLCELL_X2 FILLCELL_X1"

addFiller

setExtractRCMode -engine postRoute
setDelayCalMode -siAware true -engine aae

optDesign -postRoute -prefix postroute -setup -hold

puts "====================================================="
puts " SIGNOFF "
puts "====================================================="
verifyConnectivity
verify_drc
extractRC
rcOut -rc_corner typical -spef ${OUT_DIR}/${DESIGN}/out/post-par.spef

write_sdf ${OUT_DIR}/${DESIGN}/out/post-par.sdf -interconn all -setuphold split
streamOut ${OUT_DIR}/${DESIGN}/out/post-par.gds
report_power -hierarchy all
saveNetlist ${OUT_DIR}/${DESIGN}/out/post-par.v

streamOut ${OUT_DIR}/${DESIGN}/out/${DESIGN}.gds 

report_area > ${OUT_DIR}/${DESIGN}/rep/area.rpt
report_timing > ${OUT_DIR}/${DESIGN}/rep/final_time.rpt
report_power > ${OUT_DIR}/${DESIGN}/rep/pnr_power.rpt
saveDesign ${OUT_DIR}/${DESIGN}/out/${DESIGN}.enc.dat
exit

