function fuzzy_bat -a -d "Combines fzf with batcat for better previewing of files before selection"
    fzf --preview 'batcat --color=always {}'
end
