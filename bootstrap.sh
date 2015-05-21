#!/bin/bash
# Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory

# Files list
files="
    zshrc
    gitconfig
    tmux.conf
        "

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory
echo "Moving any existing dotfiles from ~ to $olddir" 
for file in $files; do
  if [ ! -L ~/.$file ]; then
    mv ~/.$file $olddir
  fi
done

# check if .dotfiles_old is empty
if [ ! "$(ls -A $olddir)" ]; then
  echo "Delete $olddir because it is empty"
  rm -r $olddir
fi

echo "Install oh-my-zsh if needed"
wget -q  https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# Create symlinks
echo "Creating symlinks"
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -sf $dir/$file ~/.$file
done

echo "Source .zshrc file"
zsh  ~/.zshrc

echo "Configuring TMUX"
mkdir -p ~/.tmux/plugins
echo "Cloning tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "Install tmux plugings"
tmux start-server
tmux new-session -d
~/.tmux/plugins/tpm/scripts/install_plugins.sh
