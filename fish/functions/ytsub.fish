function ytsub --description 'Download subtitles only (clean)'
    yt-dlp \
        --skip-download \
        --write-subs \
        --write-auto-subs \
        --sub-lang en \
        --sub-format srt \
        -o "%(title)s.%(ext)s" \
        $argv
end
