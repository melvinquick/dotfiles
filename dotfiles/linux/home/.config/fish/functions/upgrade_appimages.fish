function upgrade_appimages -d "Repeatedly upgrade appimages using the AM manager (if already installed)"
    echo --------------------
    echo '| APPIMAGE UPDATES |'
    echo --------------------
    am -u && am -c
    echo
end
