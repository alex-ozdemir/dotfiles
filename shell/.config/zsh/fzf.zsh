function fzo {
    directories=(~/resources ~/repos ~/personal ~/stanford)
    if [ $# -gt 0 ]
    then
        f=$({fd '' $@; fd -I '.*.pdf' $@} | sort | uniq | fzf)
    else
        f=$({fd '' $directories; fd -I '.*.pdf' $directories} | sort | uniq | fzf)
    fi && xdg-open $f &
}
