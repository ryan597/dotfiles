#!/bin/bash

sudo -u $USER { 
echo Installer script for dotfiles\n
echo copying files 
cp -r ~/dotfiles/.config ~/
cp -r ~/dotfiles/.vim ~/
cp ~/dotfiles/.* ~/

echo cloning repositories for vim plugins
git clone https://github.com/itchyny/lightline.vim.git ~/.vim/pack/plugins/start/lightline
git clone https://github.com/frazrepo/vim-rainbow.git ~/.vim/pack/plugins/start/rainbow 
git clone https://github.com/powerline/fonts.git ~/dotfiles/fonts/powerlinefonts

echo installing patched fonts 
chmod +x ~/dotfiles/fonts/powerlinefonts/install.sh 
~/dotfiles/fonts/powerlinefonts/install.sh

echo installing fish and rust commands
}

apt install fish bat exa fd-find powerline fonts-powerline curl

sudo -u $USER {
chsh -s /usr/bin/fish 

echo installing oh-my-fish and bobthefish theme 
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish 
omf install bobthefish

echo replacing segment seperators in prompt 
sed -i '353 c\
            echo -ns \\\ue0b0 " "' ~/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish
sed -i '393 c\
        echo -ns \\\ue0b0 " "' ~/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish

if which conda
then
    echo initialising conda for fish 
    conda init fish
fi

echo Install finished 
}
