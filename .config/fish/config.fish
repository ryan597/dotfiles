# Remove greeting
set fish_greeting ""

# powerline
set -g theme_powerline_fonts no
#set -g theme_nerd_fonts no

# bobthefish theme
set -g theme_color_scheme nord
set -g theme_display_git_default_branch yes
set -g theme_display_git_dirty no 
set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set -g theme_date_format "+%a %H:%M"

if status is-interactive
    # Commands to run in interactive sessions can go here
end

## Aliases

# Alias exa to ls
alias ls="exa -a"
alias lsa="exa -la"

# Alias fdfind to fd
alias fd="fdfind"

# Alias batcat to bat
alias bat="batcat"

# Alias for git
alias gitc="git add . ; git commit"

# Aliases for files
alias duh="du -sh * | sort -h -r"

# Alias for grep history
alias gh="history|grep"

## Aliases for conda 
# env setup from .yml
alias cenv="conda env create -f environment.yml"
# env export to .yml
alias cexp="conda env export --no-builds  > environment.yml"

