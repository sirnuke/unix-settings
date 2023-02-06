#!/bin/sh
set -ex

sudo apt update
sudo apt install -y zsh build-essential git vim silversearcher-ag libelf-dev dkms curl tree tmux bat httpie

cp -i vimrc ~/.vimrc
cp -i -r vim ~/.vim/
cp -i zshrc ~/.zshrc
cp -i zlocal ~/.zlocal
cp -i -r fonts ~/.fonts/
cp -i nanorc ~/.nanorc

mkdir -p ~/bin

chsh -s /bin/zsh

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
