function upgrade_system
    upgrade_apps && upgrade_snaps && upgrade_flatpaks && upgrade_appimages
end
