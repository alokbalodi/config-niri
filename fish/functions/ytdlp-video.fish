function ytdlp-video --description 'yt-dlp with sane defaults'
    yt-dlp \
        -f "bv*+ba/b" \
        --merge-output-format mp4 \
        -o "%(title)s.%(ext)s" \
        $argv
end
