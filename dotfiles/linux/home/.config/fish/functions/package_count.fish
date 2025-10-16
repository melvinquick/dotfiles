function package_count -d "Gives you a total system package count (via yay)"
    yay -Q | wc -l
end
