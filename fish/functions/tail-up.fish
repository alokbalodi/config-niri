function tail-up --description "Start and connect Tailscale"
    sudo systemctl start tailscaled
    sudo tailscale up
    tailscale status
end
