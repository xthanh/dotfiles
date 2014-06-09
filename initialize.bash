#!/usr/bin/env bash
set -e

here="$(dirname "$0")"
here="$(cd "$here"; pwd)"

(cd $here; git submodule init)
(cd $here; git submodule update)

for file in "$here"/*; do
    name="$(basename "$file")"
    if [[ !( " initialize.bash oh-my-zsh-custom readme.md " =~ " $name " ) ]]; then
        if [[ -e "$HOME/.$name" ]]; then
            rm -rv "$HOME/.$name"
        fi
        ln -sfhv $file "$HOME/.$name"
    fi
done


if [[ `uname` == 'Linux' ]]; then
   platform='linux'
elif [[ `uname` == 'Darwin' ]]; then
    find "$here/oh-my-zsh-custom/custom" -type f -depth 1 -print0 | xargs -0 -L 1 -I % ln -sfhv % "$HOME/.oh-my-zsh/custom/"
    find "$here/oh-my-zsh-custom/themes" -type f -depth 1 -print0 | xargs -0 -L 1 -I % ln -sfhv % "$HOME/.oh-my-zsh/themes/"
    find "$here/oh-my-zsh-custom/custom/plugins" -depth 1 -print0 | xargs -0 -L 1 -I % ln -sfhv % "$HOME/.oh-my-zsh/custom/plugins/"
fi
