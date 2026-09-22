function fish_prompt -d "Write out the prompt"
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end
if test -f ~/.config/fish/colors.fish
    source ~/.config/fish/colors.fish
end
if status is-interactive # Commands to run in interactive sessions can go here

    set fish_greeting

    fish_vi_key_bindings

    # vim mode workarounds
    function paste_from_wl
        set -l clip (wl-paste 2>/dev/null)
        if test -n "$clip"
            commandline -i -- "$clip"
        end
    end
    
    bind p paste_from_wl
    
    function copy_to_wl
        set -l text (commandline -s)
        if test -n "$text"
            echo -n "$text" | wl-copy
        else
            commandline -y | wl-copy
        end
        commandline -f end-selection
	set -g fish_bind_mode default
	commandline -f repaint
    end
    
    bind -M visual y copy_to_wl

    bind V 'set -g fish_bind_mode visual; commandline -f beginning-of-line begin-selection end-of-line repaint'

    bind -e \t 

    bind l forward-word
    bind _m default \t forward-word
    bind -M insert \t forward-word

    fish_add_path ~/.cargo/bin

    # Aliases
    alias fm='yazi'
    alias sudo='doas'
    alias ls 'eza --icons auto'
    alias c='clear'
    alias pacman='doas pacman'
    alias cd..='cd ..'
    alias ..='cd ..'
    alias ...='cd ../../'
    alias ....='cd ../../../'
    alias .....='cd ../../../'
    alias vi='nvim'
end
