# * Aliases for Python Programming
alias bandit='bandit -c bandit.yaml -r .'

# * System Upgrades
alias upgrade-release='sudo do-release-upgrade'
alias upgrade-system='upgrade-apps && upgrade-flatpaks && upgrade-appimages'

# * Application Upgrades
alias upgrade-apps='sudo nala full-upgrade --assume-yes && sudo nala autoremove --purge --config --assume-yes --fix-broken && sudo nala clean'
alias upgrade-flatpaks='flatpak update --assumeyes'
alias upgrade-appimages='am -u && am -c'

# * Aliases for Bash Prompt
alias refresh-bash-prompt='(clear; source ~/.bashrc)'

# * Aliases for Weather
alias weather='curl wttr.in/Clearfield+PA'
