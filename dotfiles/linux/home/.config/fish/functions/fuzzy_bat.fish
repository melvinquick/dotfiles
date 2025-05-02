function fuzzy_bat -d "Combines fzf with batcat for better previewing of files before selection"
    fzf --preview 'bat --color=always {}'
end
