function upgrade_apps -d "Use nala to upgrade system apps and autoremove apps / fix broken apps"
    sudo apt modernize-sources -y sudo nala full-upgrade --assume-yes && sudo nala autoremove --purge --config --assume-yes --fix-broken && sudo nala clean
end
