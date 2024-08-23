---@diagnostic disable: lowercase-global, undefined-global

align_right = true
window_width = 1366
window_height = 768
bg_padding_x = 10
bg_padding_y = 70
bg_width = 310
bg_aspect = 1396 / 686
bg_path = "~/.config/conky/MyMimosa/res/bg6.png"

bg_vert_path = "~/.config/conky/MyMimosa/res/bg-piece-v.png"
bg_vert_width = 140
bg_vert_aspect = 720 / 270
bg_vert_padding_x = 10
bg_vert_padding_y = 50

bg_player_path = "~/.config/conky/MyMimosa/res/bg-piece.png"
bg_player_width = 310
bg_player_aspect = 270 / 720
bg_player_padding_x = 20
bg_player_padding_y = 585

player_img_width = 80
player_img_height = 65
player_img_padding_x = 20

radius = 25
thickness = 7
padding_y = 10
initial_space = bg_vert_padding_y + 2 * radius
empty = 25



settings_table = {

    {
        name = 'cpu',
        arg = 'cpu0',
        max = 100,
        bg_colour = 0xffffff,
        bg_alpha = 0.2,
        fg_colour = 0x00d4ff,
        fg_alpha = 1,
        y = initial_space + padding_y,
        x = align_right and bg_vert_padding_x + bg_vert_width / 2 + thickness / 2 or
            window_width - bg_vert_padding_x - bg_vert_width / 2 + thickness / 2,
        radius = radius,
        thickness = thickness,
        start_angle = 0,
        end_angle = 360,
        icon = ""
    },
    {
        name = 'memperc',
        arg = '',
        max = 100,
        bg_colour = 0xFFFFFFF,
        bg_alpha = 0.2,
        fg_colour = 0x03ffb1,
        fg_alpha = 1,
        y = initial_space + padding_y + 2 * radius + thickness + empty,
        x = align_right and bg_vert_padding_x + bg_vert_width / 2 + thickness / 2 or
            window_width - bg_vert_padding_x - bg_vert_width / 2 + thickness / 2,
        radius = radius,
        thickness = 7,
        start_angle = 0,
        end_angle = 360,
        icon = ""
    },
    {
        name = 'swapperc',
        arg = '',
        max = 100,
        bg_colour = 0xFFFFFFF,
        bg_alpha = 0.0,
        fg_colour = 0x01c386,
        fg_alpha = 1,
        y = initial_space + padding_y + 2 * radius + thickness + empty,
        x = align_right and bg_vert_padding_x + bg_vert_width / 2 + thickness / 2 or
            window_width - bg_vert_padding_x - bg_vert_width / 2 + thickness / 2,
        radius = radius,
        thickness = 7,
        start_angle = 0,
        end_angle = 360,
        icon = ''
    },
    {
        name = 'battery_percent',
        arg = 'BAT0',
        max = 100,
        bg_colour = 0xFFFFFF,
        bg_alpha = 0.2,
        fg_colour = 0x03ff60,
        fg_alpha = 1,
        y = initial_space + padding_y + 2 * (2 * radius + thickness + empty),
        x = align_right and bg_vert_padding_x + bg_vert_width / 2 + thickness / 2 or
            window_width - bg_vert_padding_x - bg_vert_width / 2 + thickness / 2,
        radius = radius,
        thickness = 7,
        start_angle = 0,
        end_angle = 360,
        icon = "󰂎"
    },
    {
        name = 'acpitemp',
        arg = '',
        max = 100,
        bg_colour = 0xFFFFFF,
        bg_alpha = 0.2,
        fg_colour = 0x03ff24,
        fg_alpha = 1,
        y = initial_space + padding_y + 3 * (2 * radius + thickness + empty),
        x = align_right and bg_vert_padding_x + bg_vert_width / 2 + thickness / 2 or
            window_width - bg_vert_padding_x - bg_vert_width / 2 + thickness / 2,
        radius = radius,
        thickness = 7,
        start_angle = 0,
        end_angle = 360,
        icon = ""
    },


}

require 'cairo'

function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr, cr2, t, pt)
    local w, h = conky_window.width, conky_window.height

    local xc, yc, ring_r, ring_w, sa, ea = pt['x'], pt['y'], pt['radius'], pt['thickness'], pt['start_angle'],
        pt['end_angle']
    local bgc, bga, fgc, fga = pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

    local angle_0 = sa * (2 * math.pi / 360) - math.pi / 2
    local angle_f = ea * (2 * math.pi / 360) - math.pi / 2
    local t_arc = t * (angle_f - angle_0)


    -- Draw background ring
    cairo_arc(cr, xc, yc, ring_r, angle_0, angle_f)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(bgc, bga))
    cairo_set_line_width(cr, ring_w)
    cairo_stroke(cr)


    -- Draw indicator ring

    cairo_arc(cr, xc, yc, ring_r, angle_0, angle_0 + t_arc)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(fgc, fga))
    cairo_stroke(cr)

    cairo_set_source_rgb(cr2, 1, 1, 1)
    cairo_set_font_size(cr2, 16)
    cairo_select_font_face(cr2, "FiraCode Nerd Font Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_move_to(cr2, xc - 6, yc + 4)
    cairo_show_text(cr2, pt["icon"])

    if pt['name'] ~= 'swapperc' then
        cairo_select_font_face(cr2, "Abel", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);
        cairo_set_font_size(cr2, 12)
        cairo_move_to(cr2, xc - 14, yc + 45)
        cairo_show_text(cr2, string.format("%03.0f%%", t * 100))
    end
end

function conky_ring_stats()
    local function setup_rings(cr, cr2, pt)
        local str = ''
        local value = 0

        str = string.format('${%s %s}', pt['name'], pt['arg'])
        str = conky_parse(str)

        value = tonumber(str)
        if value == nil then value = 0 end
        pct = value / pt['max']

        draw_ring(cr, cr2, pct, pt)
    end

    if conky_window == nil then return end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual,
        conky_window.width, conky_window.height)

    local cr = cairo_create(cs)
    local cr2 = cairo_create(cs)

    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)


    if update_num > 5 then
        for i in pairs(settings_table) do
            setup_rings(cr, cr2, settings_table[i])
        end
    end
    cairo_surface_destroy(cs)
    cairo_destroy(cr)
end

function conky_graph_example()
    return math.random(0, 100)
end

function conky_render_main_bg()
    bg_height = bg_aspect * bg_width
    bg_pos_x = 0
    bg_pos_y = 0 + bg_padding_y
    if (align_right) then
        bg_pos_x = bg_pos_x + window_width - bg_width - bg_padding_x
    else
        bg_pos_x = bg_pos_x + bg_padding_x
    end
    return string.format("${image %s -s %dx%d -p %d,%d}", bg_path, bg_width, bg_height, bg_pos_x, bg_pos_y)
end

function conky_render_vert_bg()
    bg_vert_height = bg_vert_aspect * bg_vert_width
    bg_pos_x = 0
    bg_pos_y = 0 + bg_vert_padding_y
    if align_right then
        bg_pos_x = bg_vert_padding_x
    else
        bg_pos_x = window_width - bg_vert_width - bg_vert_padding_x
    end
    return string.format("${image %s -s %dx%d -p %d,%d}", bg_vert_path, bg_vert_width, bg_vert_height, bg_pos_x, bg_pos_y)
end

function conky_render_player_bg()
    bg_player_height = bg_player_aspect * bg_player_width
    bg_pos_x = 0
    bg_pos_y = 0 + bg_player_padding_y
    if align_right then
        bg_pos_x = bg_pos_x + window_width - bg_width - bg_player_width - bg_player_padding_x
    else
        bg_pos_x = bg_player_width + bg_player_padding_x
    end
    return string.format("${image %s -s %dx%d -p %d,%d}", bg_player_path, bg_player_width, bg_player_height, bg_pos_x,
        bg_pos_y)
end

function conky_render_player_image(image_path)
    bg_player_height = bg_player_aspect * bg_player_width
    bg_pos_x = 0
    bg_pos_y = 0 + bg_player_padding_y + bg_player_height / 4.5
    if align_right then
        bg_pos_x = bg_pos_x + window_width - bg_width - bg_player_width - bg_player_padding_x + player_img_padding_x
    else
        bg_pos_x = bg_player_width + bg_player_padding_x + player_img_padding_x
    end
    return string.format("${image %s -s %dx%d -p %d,%d}", image_path, player_img_width, player_img_height, bg_pos_x,
        bg_pos_y)
end

function conky_base_offset()
    offset = 0
    if align_right then
        offset = window_width - bg_width - bg_padding_x
    else
        offset = bg_padding_x
    end
    return string.format("${offset %d}", offset)
end

function conky_player_base_offset()
    offset = 0
    if align_right then
        offset = window_width - bg_width - bg_player_padding_x - bg_player_width + player_img_width
    else
        offset = bg_width + bg_player_padding_x + player_img_width
    end
    return string.format("${offset %d}", offset)
end

function conky_base_voffset()
    voffset = bg_padding_y + 8
    return string.format("${voffset %d}", voffset)
end

function conky_base_vert_voffset()
    voffset = bg_vert_padding_y
    return string.format("${voffset %d}", voffset)
end

function conky_icon_offset()
    offset = align_right and bg_vert_padding_x + bg_vert_width / 2 + thickness / 2 - 10 or
        window_width - bg_vert_padding_x - bg_vert_width / 2 + thickness / 2 - 10
    return string.format("${offset %d}", offset)
end

function conky_icon_voffset(index)
    voffset = 46
    return string.format("${voffset %d}", voffset)
end
