if status is-interactive
    # * Fastfetch Call
    fastfetch --config ~/.config/fastfetch/fastfetch.jsonc

    # * Starship Eval
    starship init fish | source
end
