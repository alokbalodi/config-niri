function clip-clear
    pkill wl-paste 2>/dev/null
    sleep 0.2

    rm -rf ~/.cache/cliphist

    wl-copy ""
    wl-copy --primary ""

    # restart BOTH watchers
    wl-paste --type text --watch cliphist store &
    wl-paste --type image --watch cliphist store &

    notify-send "Clipboard cleared"
end
