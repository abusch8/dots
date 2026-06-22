#!/usr/bin/env bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TPM_INSTALL_PATH="$HOME/.tmux/plugins/tpm"

echo -e '\e[35m'
cat << 'EOF'
 ______     __  __     ______     __    __     ______     ______     ______     ______
/\  ___\   /\ \_\ \   /\  __ \   /\ "-./  \   /\  == \   /\  ___\   /\  == \   /\  ___\
\ \ \____  \ \  __ \  \ \  __ \  \ \ \-./\ \  \ \  __<,  \ \  __\   \ \  __<,  \ \___  \
 \ \_____\  \ \_\ \_\  \ \_\ \_\  \ \_\ \ \_\  \ \_____\  \ \_____\  \ \_\ \_\  \/\_____\
  \/_____/   \/_/\/_/   \/_/\/_/   \/_/  \/_/   \/_____/   \/_____/   \/_/\/_/   \/_____/
EOF
echo -e '\e[0m'

force=false

while getopts "f" opt; do
    case $opt in
        f) force=true ;;
    esac
done

function symlink {
    local src="$1"
    local dest="$2"
    if [[ -e "$dest" || -L "$dest" ]]; then
        if ! $force; then
            ans="y"
            read -r -p "$dest already exists, overwrite? [Y/n]: " ans
            if [[ "$ans" =~ ^[Yy]$ ]]; then
                echo "skipping $dest"
                return
            fi
        fi
        echo "removing $dest"
        rm -rf -- "$dest"
    fi
    echo "linking $src -> $dest"
    ln -s -- "$src" "$dest"
    echo
}

function git_config {
    echo "git config --global \"$1\" \"$2\""
    git config --global --unset-all "$1"
    git config --global "$1" "$2"
}

mkdir -p "$HOME/.config/nvim"

if [[ ! -f "$DIR/.env" ]]; then
    cp "$DIR/.env.example" "$DIR/.env"
fi

symlink "$DIR/.bashrc"      "$HOME/.bashrc"
symlink "$DIR/.vimrc"       "$HOME/.vimrc"
symlink "$DIR/.tmux.conf"   "$HOME/.tmux.conf"
symlink "$DIR/.config/nvim" "$HOME/.config/nvim"
symlink "$DIR/.env"         "$HOME/.config/nvim/.env"

git_config "alias.unstage"  "reset HEAD"
git_config "alias.uncommit" "reset HEAD^ --mixed"
git_config "branch.sort"    "committerdate"
git_config "core.autocrlf"  "false"
git_config "core.editor"    "nvim"
git_config "core.eol"       "lf"
git_config "core.pager"     "less -R"
git_config "color.status"   "always"
git_config "http.sslVerify" "false"
git_config "merge.tool"     "nvimdiff"
git_config "pull.rebase"    "false"

if [[ ! -d "$TPM_INSTALL_PATH" ]]; then
    echo
    echo "installing tmux plugin manager..."
    mkdir -p "$TPM_INSTALL_PATH"
    git clone https://github.com/tmux-plugins/tpm "$TPM_INSTALL_PATH"
fi

echo
echo "done"

