function sshand
    set user u0_a286
    set port 8022

    # 1) USB via ADB port forwarding (BEST)
    if type -q adb
        adb forward tcp:$port tcp:$port 2>/dev/null
        ssh -p $port $user@127.0.0.1 && return
    end

    # 2) Hotspot fallback
    ssh -p $port -o ConnectTimeout=2 $user@10.246.127.106 && return

    # 3) Wi-Fi fallback
    ssh -p $port -o ConnectTimeout=2 $user@192.168.1.3 && return

    echo "Android phone not reachable (USB, hotspot, Wi-Fi failed)"
end
