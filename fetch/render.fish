#!/usr/bin/env fish

# ---------------------------------
# Layout
# ---------------------------------

set -g FETCH_COLUMN_GAP 7

# ---------------------------------
# Row buffer
# ---------------------------------

function begin_render --description "Initialize the render buffer"
    set -g FETCH_ROWS
end

function add_row --argument key value --description "Add a row to the render buffer"
    set -a FETCH_ROWS (string join \t -- "$key" "$value")
end

function add_blank --description "Add a blank row to the render buffer"
    set -a FETCH_ROWS ""
end

# ---------------------------------
# Logo colors
# ---------------------------------

function expand_logo_colors --argument line
    set line (string replace -a "{1}" (theme_color 1) -- "$line")
    set line (string replace -a "{2}" (theme_color 2) -- "$line")
    set line (string replace -a "{3}" (theme_color 3) -- "$line")
    set line (string replace -a "{4}" (theme_color 4) -- "$line")
    set line (string replace -a "{5}" (theme_color 1) -- "$line")
    set line (string replace -a "{6}" (theme_color 2) -- "$line")
    set line (string replace -a "{7}" (theme_color 3) -- "$line")
    set line (string replace -a "{reset}" (theme_reset) -- "$line")

    echo "$line"
end

# ---------------------------------
# Renderer
# ---------------------------------

function render_rows --description "Render logo and rows side-by-side"

    # Determine widest visible logo line.
    set -l logo_width 0

    for line in $FETCH_LOGO_LINES
        set -l plain $line

        for token in '{1}' '{2}' '{3}' '{4}' '{5}' '{6}' '{7}' '{reset}'
            set plain (string replace -a $token "" -- "$plain")
        end

        set -l len (string length -- "$plain")

        if test $len -gt $logo_width
            set logo_width $len
        end
    end

    # Determine widest label.
    set -l label_width 0

    for row in $FETCH_ROWS
        set -l fields (string split \t -- "$row")
        set -l len (string length -- "$fields[1]")

        if test $len -gt $label_width
            set label_width $len
        end
    end

    set -l logo_count (count $FETCH_LOGO_LINES)
    set -l row_count (count $FETCH_ROWS)

    set -l total_rows (math "max($logo_count,$row_count)")

    set -l info_offset 0

    if test $logo_count -gt $row_count
        set info_offset (math "floor(($logo_count-$row_count)/2)")
    end

    for i in (seq $total_rows)

        # -------------------------
        # Logo
        # -------------------------

        set -l logo ""

        if test $i -le $logo_count
            set logo "$FETCH_LOGO_LINES[$i]"
        end

        set -l plain $logo

        for token in '{1}' '{2}' '{3}' '{4}' '{5}' '{6}' '{7}' '{reset}'
            set plain (string replace -a $token "" -- "$plain")
        end

        printf "%s" (expand_logo_colors "$logo")

        set -l pad (math "$logo_width - "(string length -- "$plain"))

        if test $pad -gt 0
            printf "%*s" $pad ""
        end

        printf "%*s" $FETCH_COLUMN_GAP ""

        # -------------------------
        # Info
        # -------------------------

        set -l row_index (math "$i-$info_offset")

        if test $row_index -ge 1
            and test $row_index -le $row_count

            if test -n "$FETCH_ROWS[$row_index]"
                set -l fields (string split \t -- "$FETCH_ROWS[$row_index]")

                printf "%-*s : %s" \
                    $label_width \
                    "$fields[1]" \
                    "$fields[2]"
            end
        end

        printf "\n"
    end
end
