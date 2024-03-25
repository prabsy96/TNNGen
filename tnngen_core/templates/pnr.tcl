setLibraryUnit -cap 1fF
setLibraryUnit -time 1ps

global init_verilog
global init_lef_file
global init_top_cell
global init_mmmc_file
global init_gnd_net
global init_pwr_net

# set vars(lef_files)             " \
#     /afs/ece.cmu.edu/usr/pvellais/Private/NCAL/custom_cell/Santha/DAC_21/asap7/asap7sc7p5t_27_R_4x_201211.lef \
#     /afs/ece.cmu.edu/usr/pvellais/Private/NCAL/custom_cell/Santha/DAC_21/asap7/asap7_tech_4x_201209.lef \

# "

#design_process_node 7
            # /afs/ece.cmu.edu/usr/pvellais/Private/NCAL/custom_cell/Santha/DAC_21/asap7/asap7sc7p5t_27_R_4x_201211.lef"]
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
set init_verilog   $RTL_PATH 
set init_top_cell  $DESIGN
set init_gnd_net   "VSS"
set init_pwr_net   "VDD"
setDesignMode -process 7 -node N7

#source <your_global_init_files>.globals
#set_dont_use {SDFLx4_ASAP7_75t_R SDFLx3_ASAP7_75t_R SDFLx2_ASAP7_75t_R SDFLx1_ASAP7_75t_R SDFHx4_ASAP7_75t_R SDFHx3_ASAP7_75t_R SDFHx2_ASAP7_75t_R SDFHx1_ASAP7_75t_R ICGx8DC_ASAP7_75t_R ICGx6p67DC_ASAP7_75t_R ICGx5p33DC_ASAP7_75t_R ICGx5_ASAP7_75t_R ICGx4_ASAP7_75t_R ICGx4DC_ASAP7_75t_R ICGx3_ASAP7_75t_R ICGx2p67DC_ASAP7_75t_R ICGx2_ASAP7_75t_R ICGx1_ASAP7_75t_R DLLx3_ASAP7_75t_R DLLx2_ASAP7_75t_R INVxp67_ASAP7_75t_R INVxp33_ASAP7_75t_R INVx8_ASAP7_75t_R INVx6_ASAP7_75t_R INVx5_ASAP7_75t_R INVx4_ASAP7_75t_R INVx3_ASAP7_75t_R INVx2_ASAP7_75t_R INVx1_ASAP7_75t_R  INVx13_ASAP7_75t_R INVx11_ASAP7_75t_R HB4xp67_ASAP7_75t_R HB3xp67_ASAP7_75t_R  HB2xp67_ASAP7_75t_R HB1xp67_ASAP7_75t_R CKINVDCx9p33_ASAP7_75t_R CKINVDCx8_ASAP7_75t_R CKINVDCx6p67_ASAP7_75t_R  CKINVDCx5p33_ASAP7_75t_R CKINVDCx20_ASAP7_75t_R } false

init_design

#set_dont_use {SDFLx4_ASAP7_75t_R SDFLx3_ASAP7_75t_R SDFLx2_ASAP7_75t_R SDFLx1_ASAP7_75t_R SDFHx4_ASAP7_75t_R SDFHx3_ASAP7_75t_R SDFHx2_ASAP7_75t_R SDFHx1_ASAP7_75t_R ICGx8DC_ASAP7_75t_R ICGx6p67DC_ASAP7_75t_R ICGx5p33DC_ASAP7_75t_R ICGx5_ASAP7_75t_R ICGx4_ASAP7_75t_R ICGx4DC_ASAP7_75t_R ICGx3_ASAP7_75t_R ICGx2p67DC_ASAP7_75t_R ICGx2_ASAP7_75t_R ICGx1_ASAP7_75t_R DLLx3_ASAP7_75t_R DLLx2_ASAP7_75t_R INVxp67_ASAP7_75t_R INVxp33_ASAP7_75t_R INVx8_ASAP7_75t_R INVx6_ASAP7_75t_R INVx5_ASAP7_75t_R INVx4_ASAP7_75t_R INVx3_ASAP7_75t_R INVx2_ASAP7_75t_R INVx1_ASAP7_75t_R  INVx13_ASAP7_75t_R INVx11_ASAP7_75t_R HB4xp67_ASAP7_75t_R HB3xp67_ASAP7_75t_R  HB2xp67_ASAP7_75t_R HB1xp67_ASAP7_75t_R CKINVDCx9p33_ASAP7_75t_R CKINVDCx8_ASAP7_75t_R CKINVDCx6p67_ASAP7_75t_R  CKINVDCx5p33_ASAP7_75t_R CKINVDCx20_ASAP7_75t_R } false
#setDontUse bufferName false
# this is example tcl to make a flexible floorplan size

#set cellheight [expr 0.270 * 4 ]
#set cellhgrid  0.216

#set fpxdim [expr $cellhgrid * 1200 ]
#set fpydim [expr $cellheight * 222 ]
floorPlan -site coreSite -s 259.2 5400.0 0 0 0 0
add_tracks -honor_pitch
#puts "Floorplan is $fpxdim by $fpydim"
#puts "Total area is [expr $fpxdim * $fpydim ] square um"
#puts "[expr $fpydim / $cellheight] standard cell rows tall"

# Innovus is not putting tracks on the bottom cell row. That causes problems
# since it won't route to them on proper tracks.

# This moves the core up one.
# Weirdly, it moves it up 1.008, but that seems to fix the track issue.
changeFloorplan -coreToBottom 1.08

add_tracks -honor_pitch 

clearGlobalNets
# globalNetConnect VDD -type pgpin -pin vdd -inst * -module {}
# globalNetConnect VSS -type pgpin -pin vss -inst * -module {}
globalNetConnect VDD -type pgpin -pin VDD -inst * -module {}
globalNetConnect VSS -type pgpin -pin VSS -inst * -module {}

#addWellTap -cell TAPCELL_ASAP7_75t_R -cellInterval 50 -inRowOffset 10.564

setAddStripeMode -stacked_via_bottom_layer M1 \
    -stacked_via_top_layer M2

sroute -connect { blockPin padPin padRing corePin floatingStripe } \
    -layerChangeRange { M1 Pad } \
    -blockPinTarget { nearestTarget } \
    -padPinPortConnect { allPort oneGeom } \
    -padPinTarget { nearestTarget } \
    -corePinTarget { firstAfterRowEnd } \
    -floatingStripeTarget { blockring padring ring stripe ringpin blockpin followpin } \
    -allowJogging 1 \
    -crossoverViaLayerRange { M1 Pad } \
    -nets { VDD VSS } \
    -allowLayerChange 1 \
    -blockPin useLef \
    -targetViaLayerRange { M1 }

### Intervene Here. Manually fix the Top M1 Follow Rail

# setViaGenMode -viarule_preference { M2_M1p }
source $M2_FILE 

setViaGenMode -viarule_preference { M6_M5widePWR1p152 M5_M4widePWR0p864 M4_M3widePWR0p864 }

# ! VALUES BELOW MAY NEED TO BE ADJUSTED FOR HOW innovus INTERPRETS YOUR FLOORPLAN

# has to be 5, 9, 13, ... change the 8 to widen by 4 min widths

set m3pwrwidth [expr 0.072 * (5 + (4 * 2))]
set m3pwrset2settracks  220
set m3pwrset2setdist    [expr $m3pwrset2settracks * 0.144]
print "M3 PWR width, temp and set to set distance: $m3pwrwidth $m3pwrset2settracks $m3pwrset2setdist"

# must be odd multiple of width and space so we get an even number of intervening tracks and stay on grid

set m3pwrspacing [expr 0.072 * 21]

# the xoffset specifies the left edge of the 1st wire.
# since the 1st track is wire (not 1/2 space) now we need an even number (width + space) for xoffset

set m3pwrxoffset [expr (0.072 * 26) + 0.036]
print "M3 PWR spacing and offset: $m3pwrspacing $m3pwrxoffset"

addStripe -extend_to design_boundary \
    -skip_via_on_wire_shape Noshape \
    -max_same_layer_jog_length 0.32 \
    -set_to_set_distance $m3pwrset2setdist \
    -skip_via_on_pin Standardcell \
    -stacked_via_top_layer Pad \
    -spacing $m3pwrspacing \
    -xleft_offset $m3pwrxoffset \
    -merge_stripes_value 0.16 \
    -layer M3 \
    -width $m3pwrwidth \
    -nets {VDD VSS} \
    -stacked_via_bottom_layer M2

set m4pwrwidth [expr 0.096 * (5 + (4 * 1))]
set m4pwrset2settracks  320
set m4pwrset2setdist    [expr $m4pwrset2settracks * 0.192]
print "M4 PWR width, temp and set to set distance: $m4pwrwidth $m4pwrset2settracks $m4pwrset2setdist"

# must be odd multiple of width and space so we get an even number of intervening tracks and stay on grid

set m4pwrspacing [expr 0.096 * 21]

# the xoffset specifies the left edge of the 1st wire.
# since the 1st track is wire (not 1/2 space) now we need an even number (width + space) for xoffset

set m4pwrxoffset [expr (0.096 * 26) - 0.036]
print "M4 PWR spacing and offset: $m4pwrspacing $m4pwrxoffset"

setAddStripeMode \
    -max_via_size { Stripe 100 100 100 } \
    -via_using_exact_crossover_size true \
    -stacked_via_bottom_layer M3 \
    -stacked_via_top_layer M4

addStripe -extend_to design_boundary \
    -direction horizontal \
    -skip_via_on_wire_shape Noshape \
    -max_same_layer_jog_length 0.32 \
    -set_to_set_distance $m4pwrset2setdist \
    -skip_via_on_pin Standardcell \
    -spacing $m4pwrspacing \
    -start_offset $m4pwrxoffset \
    -merge_stripes_value 0.16 \
    -layer M4 \
    -width $m4pwrwidth \
    -nets {VDD VSS}

set m5pwrwidth [expr 0.096 * (5 + (4 * 1))]
set m5pwrset2settracks  320
set m5pwrset2setdist    [expr $m5pwrset2settracks * 0.192]
print "M5 PWR width, temp and set to set distance: $m5pwrwidth $m5pwrset2settracks $m5pwrset2setdist"

# must be odd multiple of width and space so we get an even number of intervening tracks and stay on grid

set m5pwrspacing [expr 0.096 * 21]

# the xoffset specifies the left edge of the 1st wire.
# since the 1st track is wire (not 1/2 space) now we need an even number (width + space) for xoffset

set m5pwrxoffset [expr (0.096 * 70) + 0.024 ]
print "M5 PWR spacing and offset: $m5pwrspacing $m5pwrxoffset"

setAddStripeMode -stacked_via_bottom_layer M4 \
    -stacked_via_top_layer M5

setViaGenMode -bar_cut_orientation horizontal

addStripe -extend_to design_boundary \
    -direction vertical \
    -skip_via_on_wire_shape Noshape \
    -max_same_layer_jog_length 0.32 \
    -set_to_set_distance $m5pwrset2setdist \
    -skip_via_on_pin Standardcell \
    -spacing $m5pwrspacing \
    -start_offset $m5pwrxoffset \
    -merge_stripes_value 0.16 \
    -layer M5 \
    -width $m5pwrwidth \
    -nets {VDD VSS}

set m6pwrwidth [expr 0.128 * (5 + (4 * 1))]
set m6pwrset2settracks  220
set m6pwrset2setdist    [expr $m6pwrset2settracks * 0.256]
print "M6 PWR width, temp and set to set distance: $m6pwrwidth $m6pwrset2settracks $m6pwrset2setdist"

# must be odd multiple of width and space so we get an even number of intervening tracks and stay on grid

set m6pwrspacing [expr 0.128 * 21]

# the xoffset specifies the left edge of the 1st wire.
# since the 1st track is wire (not 1/2 space) now we need an even number (width + space) for xoffset

set m6pwrxoffset [expr (0.128 * 50) + 0.008 ]
print "M6 PWR spacing and offset: $m6pwrspacing $m6pwrxoffset"

setAddStripeMode -stacked_via_bottom_layer M5 \
    -stacked_via_top_layer M6

setViaGenMode -bar_cut_orientation vertical

addStripe -extend_to design_boundary \
    -direction horizontal \
    -skip_via_on_wire_shape Noshape \
    -max_same_layer_jog_length 0.32 \
    -set_to_set_distance $m6pwrset2setdist \
    -skip_via_on_pin Standardcell \
    -spacing $m6pwrspacing \
    -start_offset $m6pwrxoffset \
    -merge_stripes_value 0.16 \
    -layer M6 \
    -width $m6pwrwidth \
    -nets {VDD VSS}

timeDesign -prePlace

createBasicPathGroups

setMaxRouteLayer 6
#set_interactive_constraint_modes common
#create_clock -name clk  -period 200 -waveform {0 100} [get_ports clk]
report_clocks
setOptMode -usefulSkew false \
    -allEndPoints true \
    -fixHoldAllowSetupTnsDegrade false 

# placement pre-clock cts goes here...
# check timing
placeDesign
report_timing

# if neg slack
optDesign -preCTS
optDesign -incremental

setPlaceMode -place_global_place_io_pins true
place_opt_design

# CTS

setNanoRouteMode -drouteMinimizeLithoEffectOnLayer {f t t t t t t t t t} \
    -routeTopRoutingLayer 5 -routeBottomRoutingLayer 2 \
    -routeWithViaInPin true 

# set desired clock cells here...
setCCOptMode -cts_buffer_cells {HB4xp67_ASAP7_75t_R HB3xp67_ASAP7_75t_R  HB2xp67_ASAP7_75t_R HB1xp67_ASAP7_75t_R CKINVDCx9p33_ASAP7_75t_R CKINVDCx8_ASAP7_75t_R CKINVDCx6p67_ASAP7_75t_R  CKINVDCx5p33_ASAP7_75t_R CKINVDCx20_ASAP7_75t_R}
setCCOptMode -cts_inverter_cells {INVxp67_ASAP7_75t_R INVxp33_ASAP7_75t_R INVx8_ASAP7_75t_R INVx6_ASAP7_75t_R INVx5_ASAP7_75t_R INVx4_ASAP7_75t_R INVx3_ASAP7_75t_R INVx2_ASAP7_75t_R INVx1_ASAP7_75t_R  INVx13_ASAP7_75t_R INVx11_ASAP7_75t_R}
setCCOptMode -cts_clock_gating_cells {SDFLx4_ASAP7_75t_R SDFLx3_ASAP7_75t_R SDFLx2_ASAP7_75t_R SDFLx1_ASAP7_75t_R SDFHx4_ASAP7_75t_R SDFHx3_ASAP7_75t_R SDFHx2_ASAP7_75t_R SDFHx1_ASAP7_75t_R ICGx8DC_ASAP7_75t_R ICGx6p67DC_ASAP7_75t_R ICGx5p33DC_ASAP7_75t_R ICGx5_ASAP7_75t_R ICGx4_ASAP7_75t_R ICGx4DC_ASAP7_75t_R ICGx3_ASAP7_75t_R ICGx2p67DC_ASAP7_75t_R ICGx2_ASAP7_75t_R ICGx1_ASAP7_75t_R DLLx3_ASAP7_75t_R DLLx2_ASAP7_75t_R}
set_ccopt_property target_skew 74ps 
set_ccopt_property target_max_trans 115ps
setNanoRouteMode -routeTopRoutingLayer 5 -routeBottomRoutingLayer 2
create_route_type -name ccopt_route_group -bottom_preferred_layer 4 -top_preferred_layer 5
create_ccopt_clock_tree_spec
ccopt_design -cts

# report on clocks and check results
optDesign -postCts 

congRepair

# optimize design as desired

setNanoRouteMode -drouteMinimizeLithoEffectOnLayer {t t t t t t t t t t} 

# -routeWithViaInPin true -- so it does not extend the M1 pins in cells

setNanoRouteMode -routeWithViaInPin true \
    -routeDesignFixClockNets true \
    -routeTopRoutingLayer 6

# route and optimize as desired
routeDesign

# all done--finish up with decap and finally filler

addFiller -cell {DECAPx10_ASAP7_75t_R  } -prefix FILLER_DECAP_
addFiller -cell {DECAPx6_ASAP7_75t_R   } -prefix FILLER_DECAP_
addFiller -cell {DECAPx4_ASAP7_75t_R   } -prefix FILLER_DECAP_

addFiller -cell {TAPCELL_ASAP7_75t_R } -prefix FILLER_TAP_
addFiller -cell {FILLER_ASAP7_75t_R FILLERxp5_ASAP7_75t_R } -prefix FILLER_

# do your final checks and write the design out
verifyConnectivity
verify_drc
#optDesign -postRoute 

saveNetlist ${OUT_DIR}/${DESIGN/out/${DESIGN}.v
extractRC
rcOut -rc_corner typical -spef ${OUT_DIR}/${DESIGN}/out/post-par.spef

streamOut ${OUT_DIR}/${DESIGN}/out/column.gds 

report_area > ${OUT_DIR}/${DESIGN}/rep/area.rpt
report_timing > ${OUT_DIR}/${DESIGN}/rep/final_time.rpt
report_power > ${OUT_DIR}/${DESIGN}/rep/pnr_power.rpt
saveDesign ${OUT_DIR}/${DESIGN}/out/column.enc.dat