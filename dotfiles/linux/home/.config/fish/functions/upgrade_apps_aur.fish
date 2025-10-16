function upgrade_apps_aur -d "Use yay to upgrade system apps and autoremove apps / fix broken apps"
    yay -Syu --noconfirm && yay -Sc --noconfirm
end
