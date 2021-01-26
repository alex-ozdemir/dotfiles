function search_bib {
    rg -U --multiline-dotall "@\\w*\\{[^}]*$1[^}]*^\\}" ~/repos/cryptobib --no-filename | rg --no-filename '\btitle\b|author|@' | rg "$1|^"
}
