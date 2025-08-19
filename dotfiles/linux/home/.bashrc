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
    fzf --preview 'bat --color=always {}'
}

package_count() { # * Gives you a total system package count (via pacman)
    pacman -Q | wc -l
}

python_version() { # * Quickly get current Python version in use on your system / venv
    python --version
}

reboot_pending_check() { # * This will check to see if the kernel version that's active is the current version on the system
    active_kernel=$(uname -r | sed 's/\./-/g')
    current_kernel=$(sip kernel | grep "linux " | awk '{print $2}' | sed 's/\./-/g')

    if [ "$active_kernel" != "$current_kernel" ]; then
        echo "REBOOT REQUIRED"
        if [ ! -z "$1" ]; then
            echo "Active Kernel: $active_kernel"
            echo "Current Kernel: $current_kernel"
        fi
    else
        echo "REBOOT NOT REQUIRED"
        if [ ! -z "$1" ]; then
            echo "Active Kernel: $active_kernel"
        fi
    fi
}

search_installed_programs() { # * Pass a keyword to find any programs containing that keyword installed on your system
    if [ -z "$1" ]; then
        echo "You need to provide a keyword to search for! e.g., search_installed_programs plasma"
    else
        pacman -Qs $1 | grep -e "core/" -e "extra/" -e "community/" -e "multilib/" -e "testing/" -e "staging/" -e "aur/" -e "local/"
    fi
}

search_repo_programs() { # * Pass a keyword to find any programs containing that keyword in the repositories
    if [ -z "$1" ]; then
        echo "You need to provide a keyword to search for! e.g., search_installed_programs kubuntu"
    else
        pacman -Ss $1 | grep -e "core/" -e "extra/" -e "community/" -e "multilib/" -e "testing/" -e "staging/" -e "aur/" -e "local/"
    fi
}

upgrade_appimages() { # * Repeatedly upgrade appimages using the AM manager (if already installed)
    am -u && am -c
}

upgrade_apps() { # * Use pacman to upgrade system apps and autoremove apps / fix broken apps
    sudo pacman -Syu --noconfirm && sudo pacman -Sc --noconfirm
}

upgrade_flatpaks() { # * Upgrade all flatpaks on your system
    flatpak update --assumeyes
    flatpak uninstall --unused --assumeyes
}

upgrade_system() { # * Run a full update process including System Apps (pacman), flatpaks, and appimages
    upgrade_apps && upgrade_flatpaks && upgrade_appimages
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
alias weather='weather_checker Clearfield Pennsylvania'
alias cat='bat --color=always'
alias ls='command ls -la'
alias rpc='reboot_pending_check'

# * Fastfetch Call
fastfetch --config ~/.config/fastfetch/fastfetch.jsonc

# * Starship Eval
eval "$(starship init bash)"
