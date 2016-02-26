#!/bin/bash
# Variables

dir=$HOME/.dotfiles                    # dotfiles directory
olddir=$HOME/.dotfiles_old             # old dotfiles backup directory

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

# Manage fish shell
echo "Manage fish configuration"
if [ -d "$HOME/.config/fish" ]; then
    echo "Moving current fish config to ~/.config/fish_old"
    mv ~/.config/fish ~/.config/fish_old
fi

echo "Create the fish directory symlink"
ln -sf $dir/fish ~/.config/fish

echo "Install fisherman if needed"
if [ ! -d "$HOME/.config/fisherman" ]; then
    git clone https://github.com/fisherman/fisherman $HOME/.config/fisherman
    cd $HOME/.config/fisherman
    make
else
    echo "Fisherman is already installed"
fi

echo "Install oh-my-zsh if needed"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh"
    git clone https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
else
    echo "Oh-my-zsh is already installed"
fi

# Create symlinks
echo "Creating symlinks"
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -sf $dir/$file ~/.$file
done

echo "Source .zshrc file"
zsh  $HOME/.zshrc

echo "Configuring TMUX"
if [ ! -d "$HOME/.tmux/plugins" ]; then
    mkdir -p ~/.tmux/plugins
fi
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Cloning tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
echo "Install tmux plugings"
tmux start-server
tmux new-session -d
~/.tmux/plugins/tpm/scripts/install_plugins.sh
