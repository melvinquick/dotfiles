function upgrade_flatpaks -d "Upgrade all flatpaks on your system"
    flatpak update --assumeyes
    flatpak uninstall --unused --assumeyes
end
