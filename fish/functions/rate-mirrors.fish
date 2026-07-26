function rate-mirrors
    set TMPFILE (mktemp)
    
    echo "Ranking Arch mirrors..."
    
    command rate-mirrors arch \
                --max-delay 43200 \
                --sort-mirrors-by score_asc \
                | grep '^Server = https' \
                > $TMPFILE
    
    begin
        echo "## Official CDN"
        echo "Server = https://fastly.mirror.pkgbuild.com/\$repo/os/\$arch"
        echo
        
        echo "## Preferred Asia mirrors"
        grep 'in.arch.niranjan.co' $TMPFILE
        grep 'sg.arch.niranjan.co' $TMPFILE
        grep 'mirror.xtom.com.hk' $TMPFILE
        grep 'mirror-hk.koddos.net' $TMPFILE
        grep 'mirrors.aliyun.com' $TMPFILE
        grep 'mirror.osbeck.com' $TMPFILE
        grep 'archlinux.mirror.server24.net' $TMPFILE
        
        echo
        echo "## Additional fast mirrors"
        grep '^Server' $TMPFILE \
                        | grep -vE 'fastly|niranjan|xtom|koddos|aliyun|osbeck|server24' \
                        | head -n 5
    end | sudo tee /etc/pacman.d/mirrorlist >/dev/null
    
    rm -f $TMPFILE
    
    echo
    echo "Final mirrorlist:"
    cat /etc/pacman.d/mirrorlist
    
    echo
    echo "Refreshing pacman databases..."
    sudo pacman -Syy
end
