function tail-reset-net --description "Restart Tailscale cleanly"
    sudo resolvectl flush-caches
    sudo systemctl restart tailscaled
    sleep 1
    sudo tailscale up
    tailscale status
end
