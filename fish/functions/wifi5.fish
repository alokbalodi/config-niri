function wifi5 --description "Switch to Alok_5"
    if nmcli connection up Alok_5
        echo "✓ Connected to Alok_5 (5 GHz)"
    else
        echo "✗ Failed to connect to Alok_5 (5 GHz)"
    end
end
