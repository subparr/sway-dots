#!/bin/bash

WP_DIR="$HOME/Pictures/wp"

selected_wp=$(find "$WP_DIR" -type f | fzf --bind='j:down,k:up' \
    --preview 'chafa --size=$(tput cols)x$(tput lines) --clear {}' \
    --preview-window=up:70%:wrap)

awww img -t none "$selected_wp"

matugen -m "dark" -r lanczos3 -t scheme-content image "$selected_wp"

