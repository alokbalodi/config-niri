function tail-down --description "Disconnect and stop Tailscale"
    sudo tailscale down
    sudo systemctl stop tailscaled
end
