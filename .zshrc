export GIT_PROMPT_EXECUTABLE="haskell"
source ~/src/zsh-git-prompt/zshrc.sh
export KEYTIMEOUT=1
export EDITOR=nvim
export PAGER=less
bindkey -v

ttyctl -f
setopt completealiases
setopt HIST_IGNORE_DUPS

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
autoload -U colors && colors
zstyle ':completion:*' menu select
autoload -Uz compinit && compinit
autoload -U promptinit && promptinit

zstyle ':completion:*' rehash true

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

PROMPT='%{$fg[yellow]%}[%{$reset_color%}%{$fg[blue]%}%D{%a %d-%m-%Y}%{$reset_color%} %{$fg[red]%}%D{%H:%M:%S}%{$reset_color%}%{$fg[yellow]%}]%{$reset_color%} %{$fg[yellow]%}[%{$reset_color%}%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}%{$fg[yellow]%}]%{$reset_color%} $(git_super_status)'$'\n''%# '
RPROMPT=""
source ~/.aliases
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function zle-line-init zle-keymap-select {
VIM_PROMPT_NORMAL="%{$fg_bold[red]%}[ -- NORMAL -- ]%{$reset_color%}"
VIM_PROMPT_INSERT="%{$fg_bold[yellow]%}[ -- INSERT -- ]%{$reset_color%}"
RPS1="${${KEYMAP/vicmd/$VIM_PROMPT_NORMAL}/(main|viins)/$VIM_PROMPT_INSERT}"
zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

noop () { }
zle -N noop
bindkey -M vicmd '\e' noop

bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M viins '^R' history-incremental-search-backward


#[[ ! $TERM =~ screen ]] && [ -z $TMUX ] && tmux
export GOPATH=~/go
export PATH=$PATH:~/go/bin

case $TERM in
    st*)
        precmd () {print -Pn "\e]0;%n@%m: %~\a"}
esac
eval $(dircolors ~/.dircolors)

alias vi="nvim"
alias vim="nvim"
alias :e="nvim"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /etc/profile.d/vte.sh