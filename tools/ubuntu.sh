#!/bin/sh
set -e
set -x

sudo apt update
sudo apt install -y zsh meld build-essential git vim silversearch-ag libelf-dev dkms curl

cp -i vimrc ~/.vimrc
cp -i -r vim ~/.vim
cp -i zshrc ~/.zshrc
cp -i zlogout ~/.zlogout
cp -i zlocal ~/.zlocal
cp -i -r fonts ~/.fonts
cp -i nanorc ~/.nanorc
cp -i tmux.conf ~/.tmux.conf

chsh -s /bin/zsh

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
