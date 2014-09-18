#!/bin/bash
# Variables

dir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory

# Files list
files="
    .zshrc
    .gitconfig

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
  if [ ! -L ~/$file ]; then
    mv ~/$file $olddir
  fi
done

# check if .dotfiles_old is empty
if [ ! "$(ls -A $olddir)" ]; then
  echo "Delete $olddir because it is empty"
  rm -r $olddir
fi

# Create symlinks
echo "Creating symlinks"
for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -sf $dir/$file ~/$file
done

zsh  ~/.zshrc
