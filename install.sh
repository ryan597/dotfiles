#!/bin/bash

echo "---------- Installer script for dotfiles ----------"
echo "backing up files in home directory"

mkdir "backups"
mv  "/home/$USER/.bashrc" "backups/"
mv  "/home/$USER/.bash_aliases" "backups/"
mv  "/home/$USER/.vimrc" "backups/"
mv -r "/home/$USER/.vim" "backups/"
mv -r "/home/$USER/.config/Code/User/settings.json" "backups/Code/User/settings.json"

echo "copying files"
cp -r ".zshrc" ".vimrc" ".vim"  "/home/$USER/"
cp ".config/Code/User/settings.json" "/home/$USER/.config/Code/User/settings.json"

echo "cloning repositories for vim plugins"
git clone 'https://github.com/itchyny/lightline.vim.git' "/home/$USER/.vim/pack/plugins/start/lightline"
git clone 'https://github.com/frazrepo/vim-rainbow.git' "/home/$USER/.vim/pack/plugins/start/rainbow"

echo "installing Zsh, Rust commands, powerlevel10k and yay (for arch based)"
echo "Enter password for sudo"

if  which apt ; then
    echo "using apt"
    sudo apt install zsh bat exa fd-find fonts-powerline
elif  which pacman ; then
    echo "using pacman"
    sudo pacman -Sy zsh bat exa fd powerline powerline-fonts
    echo "installing yet another yogurt"
    pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    echo "yay installed... using yay to install powerlevel10k and patched fonts"
    yay -S --noconfirm ttf-meslo-nerd-font-powerlevel10k zsh-theme-powerlevel10k-git
    echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
else
    echo "installation failed, make sure apt or pacman is available or edit the install script to work with your package manager"
    echo "Exiting..."
    exit 1
fi

echo 'changing shell to zsh'
chsh -s /bin/zsh

if  which conda ; then
    echo initialising conda
    conda init zsh
fi

echo "---------- Install finished ----------"
