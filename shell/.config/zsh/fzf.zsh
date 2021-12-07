function fzo {
    if [ $# -gt 0 ]
    then
        f=$(fd '' $@ | fzf)
    else
        f=$(fd '' ~/resources ~/repos ~/personal ~/stanford | fzf)
    fi
    xdg-open $f &
}
