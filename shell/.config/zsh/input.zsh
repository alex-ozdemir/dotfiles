bindkey -v
function zle-line-init zle-keymap-select {
    RPS1="%F{yellow}${${KEYMAP/vicmd/vim}/(main|viins)/}%f"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
bindkey "^R" history-incremental-search-backward
bindkey "^?" backward-delete-char
bindkey "^U" kill-whole-line
