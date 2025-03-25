# * History Settings
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# * Window Settings
shopt -s checkwinsize

# * Function Definitions
bandit_check() { # * Will run bandit as long as you're in a directory with a bandit.yaml file to feed it information
    bandit -c bandit.yaml -r .
}

better_clear() { # * Upgraded clear command that will re-source your fish config upon run so that you have a refreshed terminal
    command clear && source ~/.bashrc
}

fuzzy_bat() { # * Combines fzf with batcat for better previewing of files before selection
    fzf --preview 'batcat --color=always {}'
}

package_count() { # * Gives you a total system package count (via nala)
    nala list -i | grep 'is installed$' -B 1 | grep -v 'is installed$' | sed 's/^[ \t]*//' | sed 's/ .*$//' | grep -v '^--$' | wc -l
}

python_version() { # * Quickly get current Python version in use on your system / venv
    python3 --version
}

search_installed_programs() { # * Pass a keyword to find any programs containing that keyword installed on your system
    if [ -z "$1" ]; then
        echo "You need to provide a keyword to search for! e.g., search_installed_programs kubuntu"
    else
        nala search "$1" -i | grep 'is installed$' -B 1 | grep -v 'is installed$' | sed 's/^[ \t]*//' | sed 's/ .*$//' | grep -v '^--$' | grep "$1" | awk '{print $1}'
    fi
}

search_repo_programs() { # * Pass a keyword to find any programs containing that keyword in the repositories
    if [ -z "$1" ]; then
        echo "You need to provide a keyword to search for! e.g., search_installed_programs kubuntu"
    else
        nala search $1 | sed 's/^[ \t]*//' | sed 's/ .*$//' | grep -v '^--$' | grep $1 | awk '{print $1}'
    fi
}

upgrade_appimages() { # * Repeatedly upgrade appimages using the AM manager (if already installed)
    am -u && am -c
}

upgrade_apps() { # * Use nala to upgrade system apps and autoremove apps / fix broken apps
    sudo nala full-upgrade --assume-yes && sudo nala autoremove --purge --config --assume-yes --fix-broken && sudo nala clean
}

upgrade_flatpaks() { # * Upgrade all flatpaks on your system
    flatpak update --assumeyes
}

upgrade_release() { # * Upgrade your current release to whatever the most recent stable release your settings allow
    sudo do-release-upgrade
}

upgrade_snaps() { # * Refresh (upgrade) snaps on your system in case the auto-upgrade isn't working
    snap refresh
}

upgrade_system() { # * Run a full update process including System Apps (Nala), Snaps, Flatpaks, and AppImages
    upgrade_apps && upgrade_snaps && upgrade_flatpaks && upgrade_appimages
}

weather_checker() { # * Quickly get your local weather in your terminal using wttr.in
    if [ -z "$1" ]; then
        echo "You need to provide the City AND State arguments! e.g., weather Philadelphia Pennsylvania"
    elif [ -z "$2" ]; then
        echo "You need to provide the City AND State arguments! e.g., weather Philadelphia Pennsylvania"
    else
        curl "wttr.in/$1+$2+USA?format=\n+Location:+$1,+$2+\n+Forecast:+%c+\n+Rainfall:+%p+\n+Temp:+%t(%f)+\n+Moon:+%m+\n"
    fi
}

# * Alias Definitions
alias sip='search_installed_programs'
alias srp='search_repo_programs'
alias clear='better_clear'
alias fzb='fuzzy_bat'
alias pyver='python_version'
alias upgrade='upgrade_system'
alias osupgrade='upgrade_release'
alias weather='weather_checker Clearfield Pennsylvania'
alias cat='batcat --color=always'
alias ls='command ls -la'

# * Fastfetch Call
fastfetch --config ~/.config/fastfetch/fastfetch.jsonc

# * Starship Eval
eval "$(starship init bash)"
