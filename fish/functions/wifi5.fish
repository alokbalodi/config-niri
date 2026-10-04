function wifi5 --description "Switch to Airtel_Alok_5"
    if nmcli connection up Airtel_Alok_5
        echo "✓ Connected to Airtel_Alok_5 (5 GHz)"
    else
        echo "✗ Failed to connect to Airtel_Alok_5 (5 GHz)"
    end
end
