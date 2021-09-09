function fzo {
    f=$(fd '' ~/resources ~/repos ~/personal ~/stanford | fzf)
    xdg-open $f &
}
