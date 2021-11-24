#!/bin/bash

echo Installer script for dotfiles\n
echo copying files
cp -r /home/$USER/dotfiles/.config /home/$USER/
cp -r /home/$USER/dotfiles/.vim /home/$USER/
cp /home/$USER/dotfiles/.* /home/$USER/

echo cloning repositories for vim plugins
git clone https://github.com/itchyny/lightline.vim.git /home/$USER/.vim/pack/plugins/start/lightline
git clone https://github.com/frazrepo/vim-rainbow.git /home/$USER/.vim/pack/plugins/start/rainbow
git clone https://github.com/powerline/fonts.git /home/$USER/dotfiles/fonts/powerlinefonts

echo installing patched fonts
chmod +x /home/$USER/dotfiles/fonts/powerlinefonts/install.sh
/home/$USER/dotfiles/fonts/powerlinefonts/install.sh

echo installing fish and rust commands

sudo apt install fish bat exa fd-find powerline fonts-powerline curl

chsh -s /usr/bin/fish

echo installing oh-my-fish and bobthefish theme
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf install bobthefish

echo replacing segment seperators in prompt
sed -i '353 c\
            echo -ns \\\ue0b0 " "' /home/$USER/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish
sed -i '393 c\
        echo -ns \\\ue0b0 " "' /home/$USER/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish

if which conda
then
    echo initialising conda for fish
    conda init fish
fi

echo Install finished
