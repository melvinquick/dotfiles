# * Aliases for Python Programming
alias bandit='bandit -c bandit.yaml -r .'

# * System Upgrades
alias upgrade-release='sudo do-release-upgrade'
alias upgrade-system='upgrade-apps && upgrade-flatpaks && upgrade-appimages'

# * Application Upgrades
alias upgrade-apps='sudo nala full-upgrade --assume-yes && sudo nala autoremove --purge --config --assume-yes --fix-broken && sudo nala clean'
alias upgrade-flatpaks='flatpak update --assumeyes'
alias upgrade-appimages='am -u && am -c'

# * Useful Aliases for Everyday Quality of Life
alias clearr='(clear; source ~/.bashrc)'
alias pyver='python3 --version'
alias weather='curl wttr.in/Clearfield+PA?format="\n+Location:+Clearfield,+PA+\n+Forecast:+%c+\n+Rainfall:+%p+\n+Temp:+%t(%f)+\n+Moon:+%m+\n"'
