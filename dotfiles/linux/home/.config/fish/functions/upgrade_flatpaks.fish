function upgrade_flatpaks -d "Upgrade all flatpaks on your system"
    echo -------------------
    echo '| FLATPAK UPDATES |'
    echo -------------------
    flatpak update --assumeyes
    flatpak uninstall --unused --assumeyes
    echo
end
