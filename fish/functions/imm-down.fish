function imm-down
    podman-compose -f ~/Mains/Podman/compose/immich/compose.yml down

    echo
    podman ps --filter name=immich
end
