# Use powerline
USE_POWERLINE="true"
# Source manjaro-zsh-configuration
if [[ -e /usr/share/zsh/manjaro-zsh-config ]]; then
  source /usr/share/zsh/manjaro-zsh-config
fi
# Use manjaro zsh prompt
if [[ -e /usr/share/zsh/manjaro-zsh-prompt ]]; then
  source /usr/share/zsh/manjaro-zsh-prompt
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ryan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ryan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ryan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ryan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

alias gitc="git add --all && git commit"
alias kay="ssh rsmith@kay.ichec.ie"

alias RPI="ssh -p 2222 pi@192.168.204.248"
export BASILISK=/home/ryan/Downloads/basilisk/src
export PATH=$PATH:
