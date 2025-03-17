function upgrade_appimages -a -d "Repeatedly upgrade appimages using the AM manager (if already installed)"
    am -u && am -c
end
