
create_rc_corner -name typical \
    -T 25

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

