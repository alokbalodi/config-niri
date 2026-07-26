source ~/.config/fetch/colors.fish
source ~/.config/fetch/render.fish
source ~/.config/fetch/info.fish
source ~/.config/fetch/logo.fish

function fetch --description "Display custom system information"

    load_logo

    begin_render

    system_info
    hardware_info
    status_info

    render_rows
end
