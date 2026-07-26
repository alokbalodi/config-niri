function tail-check --description "Check Tailscale connectivity and status"
    echo "=== Tailscale Status ==="
    tailscale status

    echo ""
    echo "=== Network Check ==="
    tailscale netcheck

    echo ""
    echo "=== DNS on tailscale0 ==="
    resolvectl dns tailscale0 2>/dev/null
end
