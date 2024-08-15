# Lines configured by zsh-newuser-install
setopt beep
unsetopt autocd
bindkey -v
setopt beep
# End of lines configured by zsh-newuser-install
zstyle :compinstall filename '/home/omega16/.zshrc'

autoload -Uz compinit
compinit
#
# My personal folder for my local scripts
path+=("${HOME}/.bin")
export PATH
systemctl --user import-environment PATH

function to_project(){
  cd "$PROJECTS_DIR/$1"
}

function enable_python_env(){
  source .env/bin/activate
}

function enable_nix_env(){
  nix develop -c zsh
}

function compilador(){
  to_project "octizys"
}

function lambda(){
  to_project "Lambda"
}

function game(){
  to_project "tower_offense"
}

function mal(){
  to_project "mal/impls/python.3"
  enable_python_env
}

function megu(){
  to_project "Degumin"
  enable_python_env
}

function parser(){
  to_project "ParserGenerator"
  enable_python_env
}

function work(){
  source "$WORK_DIR/env.zsh"
  cd "$WORK_DIR/$WORK_CURRENT_PROJECT"
  enable_nix_env
}

function make_with_git_root(){
  root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ $? -ne 0 ]] then
    echo "can't find git root"
  else 
    echo "hi $root"
    #make $1 -C $root
    npm run $1
  fi
}

function test(){
  make_with_git_root "test"
}

function build(){
  make_with_git_root "build"
}

function run(){
  make_with_git_root "run"
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
