function upgrade_system -d "Run a full update process including System Apps (Nala), Snaps, Flatpaks, and AppImages"
    upgrade_apps && upgrade_snaps && upgrade_flatpaks && upgrade_appimages
end
