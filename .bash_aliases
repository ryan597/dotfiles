# Alias for git
alias "gitc"="git add . ; git commit"

# Aliases for files
alias duh="du -sh * | sort -h -r"

# Alias for grep history
alias gh="history|grep"

## Aliases for conda 
# env setup from .yml
alias cenv="conda env create -f environment.yml"
# env export to .yml
alias cexp="conda env export --no-builds  > environment.yml"

# ICHEC
alias kay="ssh rsmith@kay.ichec.ie"
