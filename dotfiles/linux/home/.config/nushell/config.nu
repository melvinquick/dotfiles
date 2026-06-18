#?###################
#?# INFORMATIONAL ###
#?###################

# * Author: Melvin quick
# * Last Updated: 2026-05-26
# * Notes: This config is best viewed with the Better Comments extension by Aaron Bond in VS Code

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

def delete_unused_dependencies [] {
    sudo pacman -Rns ...(pacman -Qdtq | lines)
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

def list_database_errors [] {
    print "-------------------"
    print "| DATABASE ERRORS |"
    print "-------------------"
    pacman -Dk
    print "\n"
}

def list_foreign_packages [] {
    print "--------------------"
    print "| FOREIGN PACKAGES |"
    print "--------------------"
    if (try { pacman -Qm } | is-empty) {
        print "No foreign packages found!"
        } else {
            pacman -Qm
        }
    print "\nBe sure to keep on top of any packages in this output for security reasons! Always read the PKGBUILD!"
    print "\n"
}

def os_install_age [] {
    let install_date: string = head -n 1 /var/log/pacman.log | awk '{print substr($1,2,10)}'
    let install_date_datetime: any = $install_date | into datetime
    let today: any = date now | format date "%Y-%m-%d" | into datetime
    
    let os_install_age: int = ($today - $install_date_datetime) / 1day | math floor

    print $"OS Install Date: ($install_date)"
    print $"OS Age: ($os_install_age) Days"
}

def package_count [] {
    yay -Q | wc -l
}

def reboot_pending_check [
    --verbose (-v) # Display the Active and Current Kernel information currently in use
] {
    print "----------------"
    print "| REBOOT CHECK |"
    print "----------------"
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
        print "You need to provide a keyword to search for! e.g., search_installed_programs --keyword nushell"
    } else {
        let yay_matches: string = (try {yay -Qs $keyword | grep -e core/ -e extra/ -e community/ -e multilib/ -e testing/ -e staging/ -e aur/ -e local/} catch {""})
        let flatpak_matches: string = (try {flatpak list | grep -i $keyword | awk '{print "flathub/" $1}'} catch {""})
        let am_matches: string = (try {am -f $keyword| lines | where $it =~ '^\s*◆' | where $it =~ $keyword | each { |line| $"am/(($line | str replace --regex '^\s*◆\s*' '' | split row ' : ' | first | str trim))" } | to text | awk '{print $1}'} catch {""})

        let keyword_matches: string = ([$yay_matches, $flatpak_matches, $am_matches] | str join "\n" | str trim)

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
        print "You need to provide a keyword to search for! e.g., search_repo_programs --keyword nushell"
    } else {
        let yay_matches: string = (try {yay -Ss $keyword | grep -e core/ -e extra/ -e community/ -e multilib/ -e testing/ -e staging/ -e aur/ -e local/} catch {""})
        let flatpak_matches: string = (try {flatpak search $keyword | awk -F'\t' '{print $NF "/" $1, $4}'} catch {""})
        let am_matches: string = (try {am -q $keyword | lines | where $it =~ '^\s*◆' | each { |line| $"am/(($line | str replace --regex '^\s*◆\s*' '' | split row ' : ' | first | str trim))" } | to text} catch {""})
        
        let keyword_matches: string = ([$yay_matches, $flatpak_matches, $am_matches] | str join "\n" | str trim)

        if ($keyword_matches | is-empty) {
            print $"No programs found in the Standard Repositories, Chaotic AUR, AUR, or Flathub containing the keyword '($keyword)'"
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
    clear_package_cache; upgrade_apps; clear_package_cache; upgrade_apps_aur; upgrade_flatpaks; upgrade_appimages; list_foreign_packages; list_database_errors; reboot_pending_check
}

def upgrade_uv_project_dependencies [] {
    print "---------------------------------"
    print "| UPDATING PROJECT DEPENDENCIES |"
    print "---------------------------------"
    uv lock --upgrade --color auto

    print "\n"
    
    print "--------------------------------"
    print "| SYNCING PROJECT DEPENDENCIES |"
    print "--------------------------------"
    uv sync

    print "\n"
}

def weather [
    --city (-c): string = "" # Search for weather in this city
    --state (-s): string = "" # Search for weaher in this state
    ] {
    if ($city == "") or ($state == "") {
        print "You need to provide the City AND State arguments! e.g., weather --city Philadelphia --state Pennsylvania"
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
alias upgrade = upgrade_system
alias fzb = fuzzy_bat
alias sip = search_installed_programs
alias srp = search_repo_programs
alias pc = package_count
alias hostname = sudo hostnamectl
alias uvup = upgrade_uv_project_dependencies
alias osage = os_install_age
alias dud = delete_unused_dependencies
alias lfp = list_foreign_packages
alias lde = list_database_errors

#?##############
#?# STARSHIP ###
#?##############

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")