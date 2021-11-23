#!/bin/bash

sudo -u $USER {
echo Installer script for dotfiles\n
echo copying files
cp -r /home/$SUDO_USER/dotfiles/.config /home/$SUDO_USER/
cp -r /home/$SUDO_USER/dotfiles/.vim /home/$SUDO_USER/
cp /home/$SUDO_USER/dotfiles/.* /home/$SUDO_USER/

echo cloning repositories for vim plugins
git clone https://github.com/itchyny/lightline.vim.git /home/$SUDO_USER/.vim/pack/plugins/start/lightline
git clone https://github.com/frazrepo/vim-rainbow.git /home/$SUDO_USER/.vim/pack/plugins/start/rainbow
git clone https://github.com/powerline/fonts.git /home/$SUDO_USER/dotfiles/fonts/powerlinefonts

echo installing patched fonts
chmod +x /home/$SUDO_USER/dotfiles/fonts/powerlinefonts/install.sh
/home/$SUDO_USER/dotfiles/fonts/powerlinefonts/install.sh

echo installing fish and rust commands
}

apt install fish bat exa fd-find powerline fonts-powerline curl

sudo -u $SUDO_USER {
chsh -s /usr/bin/fish

echo installing oh-my-fish and bobthefish theme
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
omf install bobthefish

echo replacing segment seperators in prompt
sed -i '353 c\
            echo -ns \\\ue0b0 " "' /home/$SUDO_USER/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish
sed -i '393 c\
        echo -ns \\\ue0b0 " "' /home/$SUDO_USER/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish

if which conda
then
    echo initialising conda for fish
    conda init fish
fi

echo Install finished
}
