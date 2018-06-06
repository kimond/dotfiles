#!/bin/bash
# Variables

dir=$HOME/.dotfiles                    # dotfiles directory
olddir=$HOME/.dotfiles_old             # old dotfiles backup directory

# Files list
files="
    zshrc
    gitconfig
    tmux.conf
    atom
    Xresources
    gitignore_global
    zpreztorc
    xmonad
    "

# Config dirs list
config_files="
    fish
    nvim
    i3
    compton.conf
    rofi
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

# Create config dir symlinks
echo "Creating config dir symlinks"
for config_file in $config_files; do
    echo "Manage $config_file configuration"
    if [ -d "$HOME/.config/$config_file" -a ! -L "$HOME/.config/$config_file" ]; then
        echo "Moving current $config_file config to ~/.config/$config_file""_old"
        mv ~/.config/$config_file ~/.config/$config_file_old
    fi

    if [ ! -L "$HOME/.config/$config_file" ]; then
        echo "Create the config or file  directory symlink"
        ln -sf $dir/$config_file ~/.config/$config_file
    fi
done

echo "Install fisherman if needed"
if [ ! -d "$HOME/.config/fisherman" ]; then
    git clone https://github.com/fisherman/fisherman $HOME/.config/fisherman
    cd $HOME/.config/fisherman
    make
else
    echo "Fisherman is already installed"
fi

echo "Install Prezto if needed"
if [ ! -d "$HOME/.zprezto" ]; then
    echo "Installing Prezto"
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
else
    echo "Prezto is already installed"
fi

# Create symlinks
echo "Creating symlinks"
for file in $files; do
    if [ ! -L ~/.$file ]; then
        echo "Creating symlink to $file in home directory."
        ln -sf $dir/$file ~/.$file
    fi
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
