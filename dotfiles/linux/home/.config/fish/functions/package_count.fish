function package_count -d "Gives you a total system package count (via nala)"
    nala list -i | grep 'is installed$' -B 1 | grep -v 'is installed$' | sed 's/^[ \t]*//' | sed 's/ .*$//' | grep -v '^--$' | wc -l
end
