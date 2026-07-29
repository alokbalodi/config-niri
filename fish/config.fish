# Load custom fetch
source ~/.config/fetch/fetch.fish

# Show fetch only in Kitty
if status is-interactive
    if test "$TERM" = xterm-kitty
        fetch
    end
end

fish_add_path ~/Mains/apps/UAD

set -gx EDITOR nvim
set -gx VISUAL nvim

zoxide init fish | source
