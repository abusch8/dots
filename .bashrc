[ -f /etc/bashrc ] && . /etc/bashrc

shopt -s extglob

BOLD='\[\e[1m\]'
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
MAGENTA='\[\e[35m\]'
RESET='\[\e[0m\]'

PS1_COLOR="${MAGENTA}"

export DOTS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source "${DOTS_DIR}/.env"
source "${DOTS_DIR}/git-sh-prompt.sh"
source /usr/share/bash-completion/completions/git

export PAGER=less
export PATH="${HOME}/bin:${HOME}/.local/share/nvim/mason/bin:${PATH}"

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

# PROMPT_COMMAND='__git_ps1 "${PS1_COLOR}\u${RESET}@${PS1_COLOR}\h${RESET}:\w" "\n${BOLD}${GREEN}\$${RESET} " " (%s)"'
PS1="${PS1_COLOR}\u${RESET}@${PS1_COLOR}\h${RESET}:\w$(__git_ps1)\n${BOLD}${GREEN}\$${RESET} "

alias ssh='ssh -q'
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'

if command -v nvim >/dev/null 2>&1; then
    alias vi='nvim'
    export EDITOR='nvim'
    export VISUAL='nvim'
else
    alias vi='vim'
    export EDITOR='vim'
    export VISUAL='vim'
fi
if command -v docker compose >/dev/null 2>&1; then
    alias dc='docker compose'
fi
if command -v kubectl >/dev/null 2>&1; then
    alias k='kubectl'
fi

function ff {
    if (( $# < 1 )); then return 1; fi
    find -L "${2:-.}" -type f -path "*${1}*" \( -empty -o -exec grep -Iq . {} \; \) -print 2>/dev/null
}

function vf {
    if (( $# < 1 )); then return 1; fi
    find -L "${2:-.}" -type f -path "*${1}*" \( -empty -o -exec grep -Iq . {} \; \) -print0 2>/dev/null | xargs -0 nvim
}

function fd {
    if (( $# < 1 )); then return 1; fi
    find -L "${2:-.}" -type f -name "${1}" -delete
}

function fz {
    if (( $# < 1 )); then return 1; fi
    grep --color=auto -RIn "${2:-.}" -e "${1}" 2>/dev/null
}

function vz {
    if (( $# < 1 )); then return 1; fi
    find -L "${2:-.}" -type f -print0 2>/dev/null | xargs -0 grep -lIZ "${1}" | xargs -0 nvim -c "/${1}"
}

function fs {
    if (( $# < 2 )) || ! git -C "${3:-.}" rev-parse --is-inside-work-tree &>/dev/null; then return 1; fi
    find -L "${3:-.}" -type f -print0 | xargs -0 sed -i "s|${1}|${2}|g"
}

function vg {
    git diff --name-only | xargs nvim
}

