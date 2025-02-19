if status is-interactive
    # * Disable the Fish Interactive Shell Greeting Message
    set fish_greeting

    # * Fastfetch Call
    fastfetch --config ~/.config/fastfetch/fastfetch.jsonc

    # * Starship Eval
    starship init fish | source
end
