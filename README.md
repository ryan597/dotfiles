# Dotfiles

Configuration files I use to setup my Linux distros.

Zsh
![sample-of-shell](<images/sampleshell.png>)

NeoVim
![sample-of-vim](<images/samplevim.png>)

---

## Install

Clone the repo with one of the following commands (depending on which you prefer to use for git).

```bash
git clone https://github.com/ryan597/dotfiles.git ~/dotfiles
```

The install script supplied with this repository will automatically download and install all files.
As some packages are needed from apt, the script will ask for `sudo` access.

```bash
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

---

## What it does

- creates a backup of config files that will be replaced
- replaces the /etc/hosts file
- installs packages (see [Installs](#installs))
- installs plugins for oh-my-zsh
- creates symbolic links to config files (see [Configs](#configs))
- changes default shell to zsh
- installs miniconda
- initializes a git config

---

## Installs

- alacritty
- bat
- eza
- fd
- git
- i3-wm
- i3lock
- i3status-rust
- miniconda
- nautilus
- neovim
- nitrogen
- oh-my-zsh
- powerline
- powerline-fonts
- ripgrep
- spotify
- vscode
- yay
- zsh

## Configs

- zshrc
- p10k
- i3-wm
- i3status-rust
- NeoVim
