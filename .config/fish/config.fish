# source /usr/share/cachyos-fish-config/cachyos-config.fish

# Keybinds
set --global fish_key_bindings fish_vi_key_bindings

# Zoxide
zoxide init fish | source

function zoxide_cd
    set -l use_fuzzel 0

    # if string match -qi "*Hyprland*" "$XDG_CURRENT_DESKTOP"
    #     set use_fuzzel 1
    # end
    #
    # if test $use_fuzzel -eq 1
    set -l dir (zoxide query -l -s | rofi -dmenu | awk "{print \$2}")
    # else
    # set -l dir (zoxide query -l | fzf)
    # end

    if test -n "$dir"
        commandline "cd '$dir'"
        commandline -f execute
    end
end

bind -a alt-z zoxide_cd



# Nvim
set -gx EDITOR nvim
# Export all environment variables at once
set -gx MANPAGER 'nvim -c "set filetype=man" -c "nmap q :q!<cr>" +Man!'
set -gx PAGER 'nvim -c "nmap q :q!<cr>" +"BaleiaColorize"'

# Edit File with Sudo
alias svim='sudoedit'

# Genga
alias gengar="pokeget --hide-name glalie | fastfetch --file-raw - -c ~/.config/fastfetch/gengar.jsonc"

# overwrite greeting
function fish_greeting
    gengar
end

# Keyboard
# cat /proc/bus/input/devices | rg --context 10 "Translated"
alias kboff="sudo echo 1 | sudo tee /sys/class/input/event9/device/inhibited"
alias kbon="sudo echo 0 | sudo tee /sys/class/input/event9/device/inhibited"

#### CachyOs Aliases

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Get fastest mirrors
alias mirror="sudo cachyos-rate-mirrors"

alias tarnow='tar -acf '
alias untar='tar -zxvf '

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons=always --hyperlink' # preferred listing
alias la='eza -a  --color=always --group-directories-first --icons=always --hyperlink' # all files and dirs
alias ll='eza -l  --color=always --group-directories-first --icons=always --hyperlink' # long format
alias lt='eza -aT --color=always --group-directories-first --icons=always --hyperlink' # tree listing
alias l.="eza -a | grep -e '^\.'" # show only dotfiles

# Dotfiles
alias dot='/usr/bin/env git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME"'
alias dot-tui='/usr/bin/env lazygit --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME"'

# Change go PATH
set -x GOPATH "$HOME/.go"
set -x GOBIN "$GOPATH/bin"

# Append common directories for executable files to $PATH
fish_add_path ~/.local/bin ~/.cargo/bin ~/Applications/depot_tools $HOME/.go/bin $HOME/.nix-profile/bin

function fish_prompt --description 'Write out the prompt'
    # Salva o último comando executado (por sessão)
    set -gx NVIM_LAST_CMD (history --max=1)

    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color (fish_vcs_prompt) $normal ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end

# Fzf config
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --style=default \
  --margin=0% \
  --color=base16 \
  --preview-window 'right,border-rounded,hidden'
  --multi \
  --bind ctrl-q:toggle-all,alt-q:toggle-all,ctrl-o:toggle-preview \
  --bind ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up "

fzf --fish | source

