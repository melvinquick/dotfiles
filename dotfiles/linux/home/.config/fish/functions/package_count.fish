function package_count -d "Gives you a total system package count (via pacman)"
    pacman -Q | wc -l
end
