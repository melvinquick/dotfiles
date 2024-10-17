# * Aliases for Python Programming
alias bandit='bandit -c bandit.yaml -r .'

# * Aliases for System Updates / Installs / Uninstalls
alias upgrade-release='sudo do-release-upgrade'
alias upgrade-system='sudo nala full-upgrade --assume-yes && sudo nala autoremove --purge --config --assume-yes --fix-broken && sudo nala clean'
alias nala='sudo nala'
