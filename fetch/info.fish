#!/usr/bin/env fish

# -----------------------------
# System
# -----------------------------
function system_info
    set -l os (
        grep '^PRETTY_NAME=' /etc/os-release \
        | cut -d= -f2- \
        | string trim --chars='"'
    )

    set -l kernel (uname -r)
    set -l host (string trim < /sys/devices/virtual/dmi/id/product_name)

    set -l uptime (
        uptime -p \
        | string replace "up " ""
    )

    set -l packages (count (pacman -Qq))

    set -l session "Niri (Wayland)"
    set -l shell (fish --version | string replace "fish, version " "fish ")
    set -l terminal (basename "$TERM_PROGRAM")
    test -n "$terminal"; or set terminal kitty
    set -l display (
        niri msg outputs \
        | awk '
            /Current mode:/ {
                printf "%s @%dHz\n", $3, $5
                exit
            }
        ' \
        | string replace "x" "×"
    )
    add_blank
    add_row OS "$os"
    add_row Kernel "$kernel"
    add_row Host "$host"
    add_blank
    add_row Uptime "$uptime"
    add_row Packages "$packages"
    add_blank
    add_row Session "$session"
    add_row Shell "$shell"
    add_row Terminal "$terminal"
    add_row Display "$display"
    add_blank
end

# -----------------------------
# Hardware
# -----------------------------
function hardware_info
    set -l cpu (
        lscpu \
        | grep "Model name:" \
        | string replace "Model name:" "" \
        | string trim \
        | string replace -r '^AMD ' '' \
        | string replace -r '\s+with Radeon Graphics' '' \
        | string replace -r '\s+\([0-9]+\)' ''
    )

    set -l gpu1 "GTX 1650 Ti"
    set -l gpu2 "Radeon Vega"

    set -l ram (
        free \
        | awk '
            /^Mem:/ {
                used = $3 / 1024 / 1024
                total = $2 / 1024 / 1024
                pct = int(($3 / $2) * 100 + 0.5)

                printf "%.1f/%.1f GiB (%d%%)", used, total, pct
            }
        '
    )

    set -l disk (
    df -B1 / \
    | awk '
        NR == 2 {
            used = $3 / 1024 / 1024 / 1024
            total = $2 / 1024 / 1024 / 1024

            printf "%.1f/%.1f GiB (%s)", used, total, $5
          }
      '
    )

    add_row CPU "$cpu"
    add_row dGPU "$gpu1"
    add_row iGPU "$gpu2"
    add_row RAM "$ram"
    add_row Disk "$disk"
end

# -----------------------------
# Status
# -----------------------------
function status_info
    set -l battery N/A

    if command -sq upower
        set -l bat (upower -e | grep battery | head -n1)

        if test -n "$bat"
            set battery (
                upower -i $bat \
                | awk -F': *' '
                    /state/ {state=$2}
                    /percentage/ {pct=$2}
                    END {
                        if (state == "charging")
                            print pct " Charging"
                        else if (state == "fully-charged")
                            print pct " Full"
                        else
                            print pct
                    }'
            )
        end
    end

    set -l ip (
        ip -4 route get 1.1.1.1 2>/dev/null \
        | awk '/src/ {
            for(i=1;i<=NF;i++)
                if($i=="src"){
                    print $(i+1)
                    exit
                }
        }'
    )
    add_blank
    add_row Battery "$battery"
    add_row IP "$ip"
end
