function upgrade_flatpaks -d "Upgrade all flatpaks on your system"
    flatpak uninstall --unused
    flatpak update --assumeyes
    flatpak uninstall --unused
end
