function search_bib {
    rg -U --multiline-dotall "@\\w*\\{[^@]*$1[^@]*^\\}" ~/repos/cryptobib --no-filename | rg --no-filename -U '\btitle\b|(author =\s*"[^"]*")|@' | rg "$1|^"
}

function bibfuzz {
    rg -U --multiline-dotall "@\\w*\\{[^@]*$1[^@]*^\\}" ~/repos/cryptobib --no-filename |
        rg --no-filename -U '\btitle\b|(author =\s*"[^"]*")|@' |
        tr '\n' ' ' |
        sed 's/@/\n@/g' |
        sed 's/\s\+/ /g'|
        sed 's/@\w*{\([^,]*\),/\1 :/' |
        sed 's/\(author = \)\|\(title = \)//g' |
        fzf --no-hscroll --preview 'echo {}' --preview-window='down,wrap,8' |
        awk '{ print $1 }'
}

function bibfuzz_cp {
    bibfuzz | tr -d '\n' | copy
    sleep 0.1
}
