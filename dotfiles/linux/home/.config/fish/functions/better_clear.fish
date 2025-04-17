function better_clear -d "Upgraded clear command that will re-source your fish config upon run so that you have a refreshed terminal"
    command clear && source ~/.config/fish/config.fish
end
