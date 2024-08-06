function fzo {
    directories=(~/resources ~/repos ~/personal ~/stanford)
    depth1=(~/Downloads)
    if [ $# -gt 0 ]
    then
        f=$({fd '' $@; fd -I '.*.pdf' $@} | sort | uniq | fzf)
    else
        f=$({fd '' $directories; fd -I '.*.pdf' $directories; fd '' -d 1 $depth1} | sort | uniq | fzf)
    fi && xdg-open $f &
}
