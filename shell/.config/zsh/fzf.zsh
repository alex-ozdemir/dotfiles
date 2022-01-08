function fzo {
    directories=(~/resources ~/repos ~/personal ~/stanford)
    if [ $# -gt 0 ]
    then
        f=$({fd '' $@; fd -I '.*.pdf' $@} | fzf)
    else
        f=$({fd '' $directories; fd -I '.*.pdf' $directories} | fzf)
    fi && xdg-open $f &
}
