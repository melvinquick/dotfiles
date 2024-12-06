# * Aliases for Python Programming
alias bandit='bandit -c bandit.yaml -r .'

# * Aliases for System Updates / Installs / Uninstalls
alias upgrade-release='sudo do-release-upgrade'
alias upgrade-system='nala full-upgrade --assume-yes && nala autoremove --purge --config --assume-yes --fix-broken && nala clean && flatpak update --assumeyes && snap refresh && am -s && am -u && am -c'
alias nala='sudo nala'
alias flatpak='sudo flatpak'
alias snap='sudo snap'

# * Aliases for Bash Prompt
alias refresh-bash-prompt='(clear; source ~/.bashrc)'

# * Aliases for Weather
alias weather='curl wttr.in/Clearfield+PA'
