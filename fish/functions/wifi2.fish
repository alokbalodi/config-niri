function wifi2 --description "Switch to Alok_2.4"
    if nmcli connection up Alok_2.4
        echo "✓ Connected to Alok_2.4 (2.4 GHz)"
    else
        echo "✗ Failed to connect to Alok_2.4 (2.4 GHz)"
    end
end
