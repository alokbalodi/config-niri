#!/usr/bin/env fish

# Logo configuration
set -g FETCH_LOGO_DIR ~/.config/fetch/logos
set -g FETCH_LOGO_NAME niri

function load_logo --description "Load the configured logo into FETCH_LOGO_LINES"
    set -g FETCH_LOGO_LINES

    set logo_file "$FETCH_LOGO_DIR/$FETCH_LOGO_NAME.txt"

    if test -f "$logo_file"
        while read -l line
            set -a FETCH_LOGO_LINES "$line"
        end <"$logo_file"
    else
        echo "fetch: logo '$logo_file' not found" >&2
    end
end
