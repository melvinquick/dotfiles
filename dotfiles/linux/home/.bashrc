# * History Settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# * Window Settings
shopt -s checkwinsize

# * Alias Definitions
if [ -e ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# * Fastfetch Call
fastfetch --config ~/.config/fastfetch/fastfetch.jsonc

# * Starship Eval
eval "$(starship init bash)"
