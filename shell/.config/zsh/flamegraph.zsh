function mk_flamegraph {
    perf_file=$1
    if [[ -z $perf_file ]]
    then
        perf_file="perf.data"
    fi
    if [[ ! -a $perf_file ]]
    then
        echo "No perf data file at: $perf_file"
        return 1
    fi
    script_out=$(mktemp --tmpdir tmp.flamegraph.perf.script.XXXXXXXX)
    echo "running: perf script > $script_out"
    perf script > $script_out || return 1
    folded=$(mktemp --tmpdir tmp.flamegraph.foled.XXXXXXXX)
    echo "running: stackcollapse-perf.pl $script_out > $folded"
    stackcollapse-perf.pl $script_out > $folded || return 1
    echo "running: flamegraph.pl $folded > flamegraph.svg"
    flamegraph.pl $folded > flamegraph.svg || return 1
    rm $script_out
    rm $folded
}
