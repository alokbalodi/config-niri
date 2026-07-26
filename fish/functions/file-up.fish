function file-up
    podman-compose -f ~/Mains/Podman/compose/syncthing/compose.yml up -d
    podman-compose -f ~/Mains/Podman/compose/immich/compose.yml up -d

    echo
    podman ps --filter name=syncthing --filter name=immich
end
