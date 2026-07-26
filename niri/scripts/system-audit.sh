#!/usr/bin/env fish
# system-audit v3
# Professional Linux audit collection framework

set TIMESTAMP (date "+%Y-%m-%d_%H-%M-%S")
set OUT "$HOME/system-audit/$TIMESTAMP"
mkdir -p "$OUT"

function have
    type -q $argv[1]
end

function section
    echo
    echo "================================================================="
    echo $argv
    echo "================================================================="
    echo
end

function run_cmd
    set name $argv[1]
    set cmd $argv[2]
    echo "## $name"
    eval $cmd 2>&1
    echo
end

function run_opt
    set prog $argv[1]
    set cmd $argv[2]
    if have $prog
        eval $cmd 2>&1
    else
        echo "$prog: not installed"
    end
    echo
end

begin
section "SUMMARY"
date
run_cmd hostnamectl "hostnamectl"
run_opt fastfetch "fastfetch"
run_cmd uname "uname -a"
run_cmd uptime "uptime -p"
run_cmd users "who"
end > $OUT/00-index.md

begin
section "HARDWARE"
run_cmd lscpu "lscpu"
run_cmd free "free -h"
run_opt lsusb "lsusb"
run_opt lspci "lspci -nnk"
run_opt sensors "sensors"
run_opt dmidecode "sudo dmidecode"
run_opt acpi "acpi -V"
end > $OUT/01-hardware.md

begin
section "OS"
run_cmd osrelease "cat /etc/os-release"
run_cmd locale "locale"
run_cmd timedate "timedatectl"
run_cmd kernel "cat /proc/cmdline"
run_cmd fstab "cat /etc/fstab"
run_opt bootctl "bootctl status"
run_opt grub "sudo grub-editenv list"
run_opt mokutil "mokutil --sb-state"
if test -n "$XDG_SESSION_ID"
    run_cmd loginctl "loginctl show-session $XDG_SESSION_ID"
end
end > $OUT/02-os.md

begin
section "STORAGE"
run_cmd df "df -hT"
run_cmd lsblk "lsblk -f"
run_opt blkid "sudo blkid"
run_opt btrfs "sudo btrfs filesystem show"
run_opt smartctl "smartctl --scan"
run_opt smartctl "sudo smartctl -x /dev/nvme0"
run_opt nvme "nvme list"
run_opt nvme "nvme smart-log /dev/nvme0"
end > $OUT/03-storage.md

begin
section "NETWORK"
run_cmd ip "ip a"
run_cmd route "ip route"
run_opt nmcli "nmcli device"
run_opt resolvectl "resolvectl status"
run_opt nmcli "nmcli connection show"
run_opt bluetoothctl "bluetoothctl show"
run_opt bluetoothctl "bluetoothctl devices"
run_cmd sockets "ss -tulpn"
run_opt arp "arp -a"
end > $OUT/04-network.md

begin
section "SOFTWARE"
run_cmd pacman "pacman -Q"
run_cmd explicit "pacman -Qe"
run_cmd aur "pacman -Qm"
run_cmd orphans "pacman -Qdt"
run_opt flatpak "flatpak list"
run_opt npm "npm list -g --depth=0"
run_opt cargo "cargo install --list"
run_opt rustup "rustup show"
end > $OUT/05-software.md

begin
section "SERVICES"
run_cmd units "systemctl list-units"
run_cmd failed "systemctl --failed"
run_cmd timers "systemctl list-timers"
run_cmd enabled "systemctl list-unit-files --state=enabled"
run_cmd user_units "systemctl --user list-units"
run_cmd user_timers "systemctl --user list-timers"
run_cmd journal_errors "journalctl -b -p err"
run_opt crontab "crontab -l"
run_opt atq "atq"
end > $OUT/06-services.md

begin
section "DESKTOP"
run_opt niri "niri --version"
run_opt niri "niri msg outputs"
run_opt niri "niri msg workspaces"
run_opt niri "niri msg windows"
run_opt loginctl "loginctl session-status"
run_opt waybar "waybar --version"
end > $OUT/07-desktop.md

begin
section "AUDIO"
run_opt wpctl "wpctl status"
run_opt pactl "pactl info"
end > $OUT/07a-audio.md


begin
section "SECURITY"
run_opt nft "sudo nft list ruleset"
run_opt iptables "sudo iptables-save"
run_opt aa-status "sudo aa-status"
run_opt sestatus "sestatus"
end > $OUT/08-security.md

begin
section "PERFORMANCE"
run_cmd top "top -bn1"
run_cmd load "cat /proc/loadavg"
run_cmd critical "systemd-analyze critical-chain"
run_cmd blame "systemd-analyze blame"
end > $OUT/09-performance.md

begin
section "AUTHENTICATION"
run_cmd groups "groups"
run_opt passwd "sudo passwd -S root"
run_opt sudo "sudo -l"
run_cmd login_defs "grep -vE '^[[:space:]]*(#|\$)' /etc/login.defs"
run_opt fido2-token "fido2-token -L"
run_opt pam "grep -R 'pam_' /etc/pam.d"
end > $OUT/10-auth.md

begin
section "BOOT"
run_cmd cmdline "cat /proc/cmdline"
run_opt efibootmgr "sudo efibootmgr -v"
run_opt bootctl "bootctl status"
run_opt grub "grep -v '^#' /etc/default/grub"
end > $OUT/11-boot.md

begin
section "CONTAINERS"
run_opt podman "podman info"
run_opt podman "podman ps -a"
run_opt podman "podman images"
run_opt podman "podman system df"
run_opt podman "podman network ls"
run_opt docker "docker ps -a"
run_opt docker "docker images"
end > $OUT/12-containers.md

begin
section "VIRTUALIZATION"
run_opt virsh "virsh list --all"
run_opt virsh "virsh net-list --all"
run_opt VBoxManage "VBoxManage list vms"
run_opt VBoxManage "VBoxManage list runningvms"
end > $OUT/13-virtualization.md

begin
section "USER CONFIG"
run_cmd shell "echo \$SHELL"
run_cmd env "env | sort"
run_opt fish "cat ~/.config/fish/config.fish"
run_opt bash "cat ~/.bashrc"
run_opt zsh "cat ~/.zshrc"
end > $OUT/14-shell.md

begin
section "BACKUPS"
run_opt rsync "rsync --version"
run_opt borg "borg --version"
run_opt restic "restic version"
run_opt timeshift "timeshift --list"
run_opt snapper "snapper list"
end > $OUT/15-backups.md

begin
section "SYSTEM"
run_cmd mounts "findmnt -R"
run_cmd modules "lsmod"
run_cmd journal "journalctl -p 3 -xb"
run_cmd sysctl "sysctl -a"
run_opt fwupdmgr "fwupdmgr get-devices"
end > $OUT/16-system.md

begin
section "DOCUMENTATION"
run_opt tree "tree -L 2 ~/.config/docs"
run_opt git "git -C ~/.config status"
run_opt git "git -C ~/.config remote -v"
run_opt git "git -C ~/.config rev-parse HEAD"
run_opt git "git -C ~/.config diff --stat"
run_opt git "git -C ~/.config log --oneline -10"
end > $OUT/17-documentation.md

begin
find $OUT -type f | sort
end > $OUT/manifest.md

echo "Audit complete: $OUT"
