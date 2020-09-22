# History
HISTFILE=~/.local/share/histfile
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY    # Append (not write) to Histfile
setopt HIST_IGNORE_DUPS  # Ignore consecutive duplicates
setopt HIST_NO_STORE     # Don't save 'history' commands
setopt HIST_IGNORE_SPACE # Don't save ' '-prefiexed commands

# confusing, right now
#setopt extendedglob

# The following lines were added by compinstall

zstyle ':completion:*' add-space true
zstyle ':completion:*' completer _complete _ignored _prefix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' glob 1
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list ''
zstyle :compinstall filename '/home/aozdemir/.zshrc'

autoload -Uz compinit
compinit -d ~/.local/share/compdump
# End of lines added by compinstall

# Implementation of "same working directory"
[[ -f "${XDG_RUNTIME_DIR}/cwd" ]] && cd "$(< ${XDG_RUNTIME_DIR}/cwd)"
precmd() { pwd > "${XDG_RUNTIME_DIR}/cwd" }

# Set up the prompt
autoload -U colors
# user @ host, cwd, are you SU?, optional red error code
PROMPT="%F{red}%n%f@%F{cyan}%m%f %F{green}%0~%f %(!.!!.$) %(?..%B%F{red}[%?]%f%b )"

# Aliases
alias ll='exa -la'
alias la='exa -a'
alias l='exa -F'
alias ls='exa -h'
alias time='/usr/bin/time'
alias g=git
alias c=cargo
alias v=nvim
alias grep='grep --color=auto'
alias copy='xclip -selection clipboard -i'
alias paste='xclip -selection clipboard -o'
alias capsescape='setxkbmap -option caps:escape'
alias soften_input='pacmd load-module module-echo-cancel aec_method=webrtc'

# Source many
for file in $XDG_CONFIG_DIR/zsh/*; do
    source "$file"
done

export PYTHONPATH="$PYTHONPATH:$HOME/repos/gg/tools/pygg/"
