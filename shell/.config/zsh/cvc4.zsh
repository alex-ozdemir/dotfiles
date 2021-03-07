alias lfscc="$HOME/repos/LFSC/build/src/lfscc"
sig_home="$HOME/repos/signatures/lfsc/old"
alias cvc4_check="$HOME/repos/LFSC/build/src/lfscc \
    $sig_home/sat.plf \
    $sig_home/smt.plf \
    $sig_home/lrat.plf \
    $sig_home/drat.plf \
    $sig_home/er.plf \
    $sig_home/th_base.plf \
    $sig_home/th_bv.plf \
    $sig_home/th_bv_bitblast.plf \
    $sig_home/th_arrays.plf \
    $sig_home/th_int.plf \
    $sig_home/th_real.plf \
    $sig_home/th_lira.plf"
