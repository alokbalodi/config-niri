function ytdlp-audio --description 'yt-dlp audio only with sane defaults'
    yt-dlp \
        -x \
        --audio-format mp3 \
        --audio-quality 0 \
        -o "%(title)s.%(ext)s" \
        $argv
end
