function upgrade_apps -d "Use nala to upgrade system apps and autoremove apps / fix broken apps"
    sudo pacman -Syu --noconfirm && sudo pacman -Sc --noconfirm
end
