function play {
    d=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $1)
    m=$(printf "%02d" $((d / 60)))
    s=$(printf "%02d" $((d % 60)))
    echo $m:$s
    ffplay -vf "drawtext=text='%{pts\:gmtime\:0\:%M\\\\\:%S}/$m\\:$s':fontsize=36:fontcolor=white:box=1:boxborderw=6:boxcolor=black@0.75:x=w-tw:y=h-th" -loop 0 $1 -seek_interval 5
}
