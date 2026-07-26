function syn-up
    podman-compose -f ~/Mains/Podman/compose/syncthing/compose.yml up -d

    echo
    podman ps --filter name=syncthing
end
