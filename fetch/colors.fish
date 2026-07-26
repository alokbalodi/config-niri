function theme_color --argument id
    switch $id
        case 1
            printf '\e[38;5;39m'
        case 2
            printf '\e[38;5;45m'
        case 3
            printf '\e[38;5;51m'
        case 4
            printf '\e[38;5;255m'
        case 5
            printf '\e[38;5;214m'
        case 6
            printf '\e[38;5;220m'
        case 7
            printf '\e[38;5;15m'
    end
end

function theme_reset
    printf '\e[0m'
end
