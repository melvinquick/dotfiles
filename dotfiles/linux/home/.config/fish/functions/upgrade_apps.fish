function upgrade_apps -d "Use nala to upgrade system apps and autoremove apps / fix broken apps"
    sudo pacman -Syu && sudo pacman -Sc --noconfirm
end
