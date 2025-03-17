function bandit_check -a -d "Will run bandit as long as you're in a directory with a bandit.yaml file to feed it information"
    bandit -c bandit.yaml -r .
end
