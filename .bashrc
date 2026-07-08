[ -f /etc/bashrc ] && . /etc/bashrc

BOLD='\[\e[1m\]'
RED='\[\e[31m\]'
GREEN='\[\e[32m\]'
MAGENTA='\[\e[35m\]'
RESET='\[\e[0m\]'

PS1_COLOR="${MAGENTA}"

export DOTS_DIR=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
source "${DOTS_DIR}/.env"
source /usr/share/bash-completion/completions/git

PS1="${PS1_COLOR}\u${RESET}@${PS1_COLOR}\h${RESET}:\w\n${BOLD}${GREEN}\$${RESET} "

export PAGER=less
export PATH="${HOME}/bin:${HOME}/.local/share/nvim/mason/bin:${PATH}"

alias ssh='ssh -q'
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'
alias vi='nvim'
alias dc='docker compose'
alias k='kubectl'

shopt -s extglob

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

