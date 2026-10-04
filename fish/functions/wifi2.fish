function wifi2 --description "Switch to Airtel_Alok_2.4"
    if nmcli connection up Airtel_Alok_2.4
        echo "✓ Connected to Airtel_Alok_2.4 (2.4 GHz)"
    else
        echo "✗ Failed to connect to Airtel_Alok_2.4 (2.4 GHz)"
    end
end
