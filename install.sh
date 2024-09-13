#!/bin/bash

echo "---------- Installer script for dotfiles ----------"
echo "asking for sudo access"
sudo -v

# Backups and copying files
mkdir "backup_dotfiles"
if (( $? == 0 )); then  # dont overwrite an existing backup
    echo "backing up current files"
    mv "$HOME/.vimrc" "backup_dotfiles/"
    mv "$HOME/.vim" "backup_dotfiles/"
    mv "$HOME/.config" "backup_dotfiles/.config"
fi

echo "checking for vim plugins..."
if [ ! -e $HOME/.vim/pack/plugins/start/lightline ]; then
    git clone 'https://github.com/itchyny/lightline.vim.git' "$HOME/.vim/pack/plugins/start/lightline"
fi
if [ ! -e $HOME/.vim/pack/plugins/start/lightline ]; then
    git clone 'https://github.com/frazrepo/vim-rainbow.git' "$HOME/.vim/pack/plugins/start/rainbow"
fi

# Blocking ads and malware hosts
echo "blocking ads and malware"
# https://github.com/StevenBlack/hosts/blob/master/readme.md
sudo wget -O /etc/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts

# Installing packages
echo "installing packages"

if  which apt ; then
    sudo apt install zsh bat exa fd-find fonts-powerline
elif which pacman ; then
    sudo pacman -Sy --noconfirm --needed firefox zsh bat eza fd git base-devel powerline powerline-fonts i3-wm i3lock i3status-rust nitrogen nautilus
    if [ ! -e $HOME/Downloads/yay-bin ]; then
        echo "installing yet another yogurt"
        git clone https://aur.archlinux.org/yay-bin.git $HOME/Downloads/yay-bin
        cd $HOME/Downloads/yay-bin
        makepkg -si
        echo "yay installed... installing from AUR"
        yay -S --noconfirm --needed ttf-meslo-nerd-font-powerlevel10k visual-studio-code-bin spotify
        yay -Y --gendb
        yay -Y --devel --diffmenu=false --save
        cd $HOME/dotfiles
    fi
else
    echo "installation failed, apt or pacman not available"
fi

echo "checking for oh-my-zsh"
if [ ! -e $HOME/.oh-my-zsh ]; then
    read -n1 -p "type 'exit' to get back to install process after oh-my-zsh screen appears. \nPress any key to continue..." tmp
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    # echo "source ~/.zshrc.pre-oh-my-zsh" >> ~/.zshrc

    echo "copying oh-my-zsh plugins"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

echo "replacing config files"
cp -r ".zshrc" ".vimrc" ".vim" ".p10k.zsh" ".config" "$HOME"

# Configuring shells
if [[ $SHELL == "/bin/bash" ]]; then
    echo 'Changing preferred shell to zsh'
    chsh -s /bin/zsh
fi

if  which conda ; then
    echo initialising conda
    conda init zsh
else
    mkdir -p $HOME/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
    bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
    rm $HOME/miniconda3/miniconda.sh
    $HOME/miniconda3/bin/conda init zsh
fi

# Git configuration
if [ ! -e $HOME/.gitconfig ]; then
    read -n1 -p "Setup git config: [y]/n" configure_git
    if [ $configure_git != n ]; then
        read -p "name: " git_name
        read -p "email: " git_email
		cat <<END > $HOME/.gitconfig
# This is Git's per-user configuration file.
    [user]
    # Please adapt and uncomment the following lines:
        name = $git_name
        email = $git_email
END
    fi
fi

echo "---------- Install finished ----------"
