function fuzzy_bat -d "Combines fzf with bat for better previewing of files before selection"
    fzf --preview 'bat --color=always {}'
end
