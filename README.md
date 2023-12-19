# Dotfiles

Configuration files I use to setup my development environment on Linux distributions.

Vim
![sample-of-vim](<images/samplevim.png>)

---

## Install

Clone the repo with one of the following commands (depending on which you prefer to use for git).

```bash
git clone https://github.com/ryan597/dotfiles.git ~/dotfiles
```

The install script supplied with this repository will automatically download and install all files. As some packages are needed from apt, the script must be run as root.

```bash
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

<details>
<summary>extra</summary>

After cloning the repository, copy the dotfiles to your home directory.

```bash
cp -r ~/dotfiles/.config ~/
cp -r ~/dotfiles/.vim ~/
cp ~/dotfiles/.* ~/
ls -a ~/  # List the hidden dotfiles
```

You will now see new files and directories: `.vim`, `.vimrc` and `.config`.

---

### vim

The `.vim` directory contains the colorscheme and plugins for setting up my vim environment.
I use the `one` theme along with a powerline plugin (lightline) and bracket matching plugin (rainbow).
The commands to install these are below, see their respective README files for further customization.

```bash
git clone https://github.com/itchyny/lightline.vim.git ~/.vim/pack/plugins/start/lightline
git clone https://github.com/frazrepo/vim-rainbow.git ~/.vim/pack/plugins/start/rainbow
```

For the powerline plugin to work properly it may help to use a powerline patched font.

```bash
git clone https://github.com/powerline/fonts.git ~/Downloads/fonts/powerlinefonts
chmod +x ~/Downloads/fonts/powerlinefonts/install.sh
~/Downloads/fonts/powerlinefonts/install.sh
```

Now to configure the settings of the plugins you can amend the `.vimrc` file.
See the respective README files for help with customizing the plugins.

---

### vimrc

The `.vimrc` file is self-documenting. There is one plugin in my rc file that I have not listed above. To enable this plugin search for the `You-Complete-Me` vim plugin and follow its instructions, to enable this plugin you can uncomment lines 20 and 21 in the `.vimrc` file.

The `.vimrc` file should be in your home directory.

---

### bashrc and bash aliases

These are my bash config files. I don't use bash much anymore and opt for fish instead which is included below.
The files are also self-documenting.

---

### VScode

VScode settings are within a json file located at `~/.config/Code/User/settings.json`.
Again this file is self-documenting.

---

### fish

I use the fish shell environment. This can be installed using apt

```bash
sudo apt install fish

# Change default shell to fish
chsh -s /usr/bin/fish

# To change back, replace fish with bash
chsh -s /bin/bash
```

Fish is configured with a `config.fish` file located at `~/.config/fish/config.fish`, customizations can be made here. I have included several aliases which I find useful. The file is again self-documentating. Note that to use the file as is, you should get Rust and the below add-ons.

---

### omf

Oh-My-Fish is a helpful customization tool for the fish shell. To install on debian based platforms use

```bash
sudo apt install curl
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```
This will download and install `omf` and launch a new instance of fish.
To install the theme `bobthefish`, use the following commands to install powerline and patched fonts

```bash
sudo apt install powerline fonts-powerline
omf install bobthefish

# Test that the patched fonts work with (you should see icons appear in the terminal)
echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"
```

If the patched font install did not work correctly, clone the repo and install with the script as above in [vim](#vim)

I have made a further customization to the theme by changing the segment seperators.
In the file `~/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish`

change line 353 to `echo -ns \ue0b0 ' '`
change line 393 to `echo -ns \ue0b0 ' '`

The following command will work also

```bash
sed -i '353 c\
            echo -ns \\\ue0b0 " "' ~/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish
sed -i '393 c\
        echo -ns \\\ue0b0 " "' ~/.local/share/omf/themes/bobthefish/functions/fish_prompt.fish
```

Changes will appear when you open a new shell environment.

---

## Rust Replacements for GNU utils

For some common command line utilities I have install Rust replacements. These are bat (cat), exa (ls) and fdfind (find). I have also created aliases for these inside the `config.fish` file.

- [bat](https://github.com/sharkdp/bat)
- [exa](https://github.com/ogham/exa)
- [fd-find](https://github.com/sharkdp/fd)

```bash
sudo apt install bat exa fd-find
```

Aliases for these are already included in the `config.fish` file.

</details>
