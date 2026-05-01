# config.nu
#
# Installed by:
# version = "0.112.2"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

#?####################
#?# DEFAULT EDITOR ###
#?####################

$env.config.buffer_editor = "code"

#?###########################
#?# REMOVE WELCOME BANNER ###
#?###########################

$env.config.show_banner = false

#?###############
#?# FUNCTIONS ###
#?###############

def bandit_check [] {
    bandit -c bandit.yaml -r .
}

def clear_package_cache [] {
    sudo find /var/cache/pacman/pkg -maxdepth 1 -name 'download-*' -exec rm -rf {} +
}

def docker_upgrade [] {
    let container_name: string = basename (pwd)

    docker compose pull out+err> /dev/null;  docker compose down out+err> /dev/null; docker compose up -d out+err> /dev/null; docker image prune -af out+err> /dev/null

    if $container_name == "nextcloud" {
        sleep 5sec
        docker compose exec -u www-data app php occ upgrade out+err> /dev/null
        docker compose exec -u www-data app php occ db:add-missing-indices out+err> /dev/null
        docker compose exec -u www-data app php occ maintenance:repair --include-expensive out+err> /dev/null
        ./ssl_restart_script.sh out+err> /dev/null
    }

    print "The container upgrade process is complete!"
}

def fuzzy_bat [] {
    fzf --preview 'bat --color=always {}'
}

def package_count [] {
    yay -Q | wc -l
}

def reboot_pending_check [
    --verbose (-v) # Display the Active and Current Kernel information currently in use
] {
    let active_kernel: string = uname | get kernel-release | sed 's/\./-/g'
    let current_kernel: string = yay -Qs kernel | grep "linux " | awk '{print $2}' | sed 's/\./-/g'

    if $active_kernel != $current_kernel {
        print "REBOOT REQUIRED"
        if $verbose {
        print "Active Kernel: " $active_kernel --no-newline
        print "\nCurrent Kernel: " $current_kernel --no-newline
        }
    } else {
        print "REBOOT NOT REQUIRED"
        if $verbose {
        print "Active Kernel: " $active_kernel --no-newline
            print "\nCurrent Kernel: " $current_kernel --no-newline
        }
    }
}
def search_installed_programs [
    --keyword (-k): string = "" # Pass a keyword to search your installed applications for
    ] {
    if $keyword == "" {
        print "You need to provide a keyword to search for! e.g., search_installed_programs nushell"
    } else {
        let keyword_matches: string = (try {yay -Qs $keyword | grep -e core/ -e extra/ -e community/ -e multilib/ -e testing/ -e staging/ -e aur/ -e local/} catch {""})

        if ($keyword_matches | is-empty) {
            print $"No programs found on the system containing the keyword '($keyword)'"
        } else {
            print $keyword_matches
        }
    }
}

def search_repo_programs [
    --keyword (-k): string = "" # Pass a keyword to search the remote repositories for
    ] {
    if $keyword == "" {
        print "You need to provide a keyword to search for! e.g., search_installed_programs nushell"
    } else {
        let keyword_matches: string = (try {yay -Ss $keyword | grep -e core/ -e extra/ -e community/ -e multilib/ -e testing/ -e staging/ -e aur/ -e local/} catch {""})

        if ($keyword_matches | is-empty) {
            print $"No programs found in the Standard Repositories, Chaotic AUR, or AUR containing the keyword '$program_keyword'"
        } else {
            print $keyword_matches
        }
    }
}

def upgrade_appimages [] {
    print "--------------------"
    print "| APPIMAGE UPDATES |"
    print "--------------------"
    am -u; am -c
    print "\n"
}

def upgrade_apps_aur [] {
    print "---------------"
    print "| YAY UPDATES |"
    print "---------------"
    yay -Syu --noconfirm; yay -Sc --noconfirm
    print "\n"
}

def upgrade_apps [] {
    print "------------------"
    print "| PACMAN UPDATES |"
    print "------------------"
    sudo pacman -Syu --noconfirm; sudo pacman -Sc --noconfirm
    print "\n"
}

def upgrade_flatpaks [] {
    print "-------------------"
    print "| FLATPAK UPDATES |"
    print "-------------------"
    flatpak update --assumeyes; flatpak uninstall --unused --assumeyes
    print "\n"
}

def upgrade_system [] {
    clear_package_cache; upgrade_apps; upgrade_apps_aur; upgrade_flatpaks; upgrade_appimages; reboot_pending_check
}

def weather_checker [city: string = "", state: string = ""] {
    if ($city == "") or ($state == "") {
        print "You need to provide the City AND State arguments! e.g., weather Philadelphia Pennsylvania"
    } else {
        http get $"wttr.in/($city)+($state)+USA?format=%0A+Location:+($city),+($state)+%0A+Forecast:+%c+%0A+Rainfall:+%p+%0A+Temp:+%t\(%f\)+%0A+Moon:+%m+%0A"
    }
}

#?#############
#?# ALIASES ###
#?#############

alias ff = ^fastfetch --config ~/.config/fastfetch/fastfetch.jsonc
alias cat = bat --color=always {}
alias pyver = python --version
alias reboot = sudo reboot now
alias shutdown = sudo shutdown now
alias cpc = clear_package_cache
alias dockup = docker_upgrade
alias rpc = reboot_pending_check
alias weather = weather_checker
alias upgrade = upgrade_system
alias fzb = fuzzy_bat
alias sip = search_installed_programs
alias srp = search_repo_programs
alias pc = package_count
alias hostname = sudo hostnamectl

#?##############
#?# STARSHIP ###
#?##############

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")