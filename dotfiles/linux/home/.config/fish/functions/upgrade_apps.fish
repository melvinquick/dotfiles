function upgrade_apps -a -d "Use nala to upgrade system apps and autoremove apps / fix broken apps"
    sudo nala full-upgrade --assume-yes && sudo nala autoremove --purge --config --assume-yes --fix-broken && sudo nala clean
end
