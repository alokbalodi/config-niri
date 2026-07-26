function file-down
    podman-compose -f ~/Mains/Podman/compose/immich/compose.yml down
    podman-compose -f ~/Mains/Podman/compose/syncthing/compose.yml down

    echo
    podman ps --filter name=syncthing --filter name=immich
end
