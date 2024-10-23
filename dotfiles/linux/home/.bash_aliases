# * Aliases for Python Programming
alias bandit='bandit -c bandit.yaml -r .'

# * Aliases for System Updates / Installs / Uninstalls
alias upgrade-release='sudo do-release-upgrade'
alias upgrade-system='sudo nala full-upgrade --assume-yes && sudo nala autoremove --purge --config --assume-yes --fix-broken && sudo nala clean && sudo flatpak update --assumeyes && sudo snap refresh'
alias nala='sudo nala'
alias flatpak='sudo flatpak'
