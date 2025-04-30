function package_count -d "Gives you a total system package count (via nala)"
    pacman -Q | wc -l
end
