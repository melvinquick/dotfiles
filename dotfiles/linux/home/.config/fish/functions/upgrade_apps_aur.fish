function upgrade_apps_aur -d "Use yay to upgrade system apps and autoremove apps / fix broken apps"
    echo ---------------
    echo '| YAY UPDATES |'
    echo ---------------
    yay -Syu --noconfirm && yay -Sc --noconfirm
    echo
end
