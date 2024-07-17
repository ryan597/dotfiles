#!/bin/bash

echo "---------- Installer script for dotfiles ----------"
echo "backing up files in home directory"

# Backups and copying files
mkdir "backup_dotfiles"
mv "$HOME/.vimrc" "backup_dotfiles/"
mv "$HOME/.vim" "backup_dotfiles/"
mv "$HOME/.config" "backup_dotfiles/.config"

echo "cloning repositories for vim plugins"
git clone 'https://github.com/itchyny/lightline.vim.git' "$HOME/.vim/pack/plugins/start/lightline"
git clone 'https://github.com/frazrepo/vim-rainbow.git' "$HOME/.vim/pack/plugins/start/rainbow"


# Installing packages
echo "installing packages"
echo "Enter password for sudo: "

if  which apt ; then
    sudo apt install zsh bat exa fd-find fonts-powerline
elif which pacman ; then
    sudo pacman -Sy --noconfirm zsh bat eza fd git base-devel powerline powerline-fonts
    echo "installing yet another yogurt"
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si
    echo "yay installed... install patched fonts, vscode"
    yay -S --noconfirm ttf-meslo-nerd-font-powerlevel10k visual-studio-code-bin
    yay -Y --gendb
    yay -Y --devel --diffmenu=false --save
else
    echo "installation failed, make sure apt or pacman is available or edit the install script to work with your package manager"
    echo "Exiting..."
    exit 1
fi

echo "installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# echo "source ~/.zshrc.pre-oh-my-zsh" >> ~/.zshrc

echo "copying files"  # copying files after all installs to ensure they aren't overwritten by install processes
cp -r ".zshrc" ".vimrc" ".vim" ".p10k.zsh" ".config" "$HOME"


# Configuring shells
echo 'Changing preferred shell to zsh'
chsh -s /bin/zsh

if  which conda ; then
    echo initialising conda
    conda init zsh
fi


# Git configuration
read -n1 -p "Setup git config: [y]/n" configure_git
if [ $configure_git != n ] ; then
    read -p "name: " git_name
    read -p "email: " git_email
    echo "# This is Git's per-user configuration file.
[user]
# Please adapt and uncomment the following lines:
    name = $git_name
    email = $git_email
"
fi

echo "---------- Install finished ----------"
exit 0