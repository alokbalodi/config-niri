function imm-up
    podman-compose -f ~/Mains/Podman/compose/immich/compose.yml up -d

    echo
    podman ps --filter name=immich
end
