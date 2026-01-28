function upgrade_system -d "Run a full update process including System Apps, AUR Apps, Flatpaks, and AppImages"
    cpc && upgrade_apps && upgrade_apps_aur && upgrade_flatpaks && upgrade_appimages
end
