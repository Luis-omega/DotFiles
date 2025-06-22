# Lines configured by zsh-newuser-install
setopt beep
unsetopt autocd
bindkey -v
setopt beep
setopt HIST_IGNORE_SPACE
# End of lines configured by zsh-newuser-install
zstyle :compinstall filename '/home/omega16/.zshrc'

eval $(keychain --eval --quiet id_ed25519 5596F50478038F84DA9451D3ED943027AECAB7B4)

autoload -Uz compinit
compinit
#
# My personal folder for my local scripts
#path+=("${HOME}/.bin")
#systemctl --user import-environment PATH

function clean(){
  printf '\033[2J\033[3J\033[1;1H'
}

function to_project(){
  cd "$PROJECTS_DIR/$1"
}

function enable_nix_env(){
  nix develop -c zsh
}

function dai(){
  to_project "Daiyatsu"
}

function jam(){
  to_project "jam-cope"
  enable_nix_env
}

function oct(){
  to_project "octizys"
  enable_nix_env
}

function gra(){
  to_project "tree-sitter-octizys"
}

function test(){
  just "test"
}

function build(){
  just "build"
}

function run(){
  just "run"
}


# Added by ghcup on install
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

# Better up/down keys completion
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "$key[Up]" up-line-or-beginning-search # Up
bindkey "$key[Down]" down-line-or-beginning-search # Down
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
