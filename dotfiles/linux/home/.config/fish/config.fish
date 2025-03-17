# * Settings for only if shell is launched interactively
if status is-interactive

end

# * Set aliases for other commands and/or functions
alias sip search_installed_programs
alias srp search_repo_programs
alias clear better_clear
alias fzb fuzzy_bat
alias pyver python_version
alias upgrade upgrade_system
alias osupgrade upgrade_release
alias weather "weather_checker Clearfield Pennsylvania"
alias cat "batcat --color=always"

# * Disable the Fish Interactive Shell Greeting Message
set fish_greeting

# * Fastfetch Call
fastfetch --config ~/.config/fastfetch/fastfetch.jsonc

# * Starship Eval
starship init fish | source
