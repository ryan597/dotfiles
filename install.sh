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
    sudo pacman -Sy --noconfirm --needed firefox zsh bat eza fd git base-devel powerline powerline-fonts i3-wm i3lock i3status-rust nitrogen nautilus
    echo "installing yet another yogurt"
    git clone https://aur.archlinux.org/yay-bin.git $HOME/Downloads/yay-bin
    cd $HOME/Downloads/yay-bin
    makepkg -si
    echo "yay installed... installing from AUR"
    yay -S --noconfirm --needed ttf-meslo-nerd-font-powerlevel10k visual-studio-code-bin spotify
    yay -Y --gendb
    yay -Y --devel --diffmenu=false --save
    cd $HOME/dotfiles
else
    echo "installation failed, make sure apt or pacman is available or edit the install script to work with your package manager"
    echo "Exiting..."
    exit
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
else
    mkdir -p $HOME/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm -rf $HOME/miniconda3/miniconda.sh
    $HOME/miniconda3/bin/conda init zsh
fi


# Git configuration
read -n1 -p "Setup git config: [y]/n" configure_git
if [ $configure_git != n ] ; then
    read -p "\nname: " git_name
    read -p "email: " git_email
    echo "# This is Git's per-user configuration file.
[user]
# Please adapt and uncomment the following lines:
    name = $git_name
    email = $git_email
" > $HOME/.gitconfig
fi

echo "\n---------- Install finished ----------"