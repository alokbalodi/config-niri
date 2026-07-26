function syn-down
    podman-compose -f ~/Mains/Podman/compose/syncthing/compose.yml down

    echo
    podman ps --filter name=syncthing
end
