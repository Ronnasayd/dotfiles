---@diagnostic disable: lowercase-global, undefined-global

align_right = true
window_width = 1532
window_height = 1080
bg_padding_x = 10
bg_padding_y = 70
bg_width = 320
bg_aspect = 2.2
bg_path = "~/.config/conky/MyMimosa/res/dark4/bg-main.png"

bg_vert_path = "~/.config/conky/MyMimosa/res/dark4/bg-piece-s.png"
bg_vert_width = 220
bg_vert_aspect = 1
bg_vert_padding_x = 20
bg_vert_padding_y = 360

bg_calendar_path = "~/.config/conky/MyMimosa/res/dark4/bg-piece-h.png"
bg_calendar_width = 320
bg_calendar_aspect = 0.375
bg_calendar_padding_x = 20
bg_calendar_padding_y = 590

bg_player_path = "~/.config/conky/MyMimosa/res/dark4/bg-piece-s.png"
bg_player_width = 220
bg_player_aspect = 1.55
bg_player_padding_x = 10
bg_player_padding_y = 354

player_img_width = 180
player_img_height = player_img_width
player_img_padding_x = 10

radius = 32
thickness = 14
padding_y = 116
initial_space = bg_vert_padding_y + 2 * radius - 10
empty = 40



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
    x = align_right and bg_vert_padding_x + bg_vert_width / 4 + thickness / 2 + 20 or
        window_width - bg_vert_padding_x - bg_vert_width / 4 + thickness / 2 - 100,
    radius = radius,
    thickness = thickness,
    start_angle = 0,
    end_angle = 360,
    icon = "",
    icon_size = 24,
    suffix = '%',
    real_max = 2.50
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
    x = align_right and bg_vert_padding_x + bg_vert_width / 4 + thickness / 2 + 20 or
        window_width - bg_vert_padding_x - bg_vert_width / 4 + thickness / 2 - 100,
    radius = radius,
    thickness = thickness,
    start_angle = 0,
    end_angle = 360,
    icon = "",
    icon_size = 20,
    suffix = '%',
    real_max = 32.0
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
    x = align_right and bg_vert_padding_x + bg_vert_width / 4 + thickness / 2 + 20 or
        window_width - bg_vert_padding_x - bg_vert_width / 4 + thickness / 2 - 100,
    radius = radius,
    thickness = thickness,
    start_angle = 0,
    end_angle = 360,
    icon = '',
    icon_size = 16,
    suffix = '%'
  },
  {
    name = 'battery_percent',
    arg = 'BAT0',
    max = 100,
    bg_colour = 0xFFFFFF,
    bg_alpha = 0.2,
    fg_colour = 0x03ff60,
    fg_alpha = 1,
    y = initial_space + padding_y,
    x = align_right and bg_vert_padding_x + bg_vert_width / 3.5 + thickness / 2 + 140 or
        window_width - bg_vert_padding_x - bg_vert_width / 3.5 + thickness / 2,
    radius = radius,
    thickness = thickness,
    start_angle = 0,
    end_angle = 360,
    icon = "󰂎",
    icon_size = 16,
    suffix = '%'
  },
  {
    name = 'acpitemp',
    arg = '',
    max = 100,
    bg_colour = 0xFFFFFF,
    bg_alpha = 0.2,
    fg_colour = 0x03ff24,
    fg_alpha = 1,
    y = initial_space + padding_y + 2 * radius + thickness + empty,
    x = align_right and bg_vert_padding_x + bg_vert_width / 3.5 + thickness / 2 + 140 or
        window_width - bg_vert_padding_x - bg_vert_width / 3.5 + thickness / 2,
    radius = radius,
    thickness = thickness,
    start_angle = 0,
    end_angle = 360,
    icon = "",
    icon_size = 16,
    suffix = '°'
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

  if (pt['name'] == 'cpu' or pt['name'] == 'memperc' or pt['name'] == 'acpitemp') and t >= 0.95 then
    fgc = 0xd90707
  elseif (pt['name'] == 'cpu' or pt['name'] == 'memperc' or pt['name'] == 'acpitemp') and t >= 0.85 then
    fgc = 0xeb9d09
  end

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
  cairo_set_font_size(cr2, pt['icon_size'])
  cairo_select_font_face(cr2, "FiraCode Nerd Font Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
  cairo_move_to(cr2, xc - pt['icon_size'] / 3, yc + pt['icon_size'] / 4)
  cairo_show_text(cr2, pt["icon"])

  cairo_select_font_face(cr2, "Roboto", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);
  cairo_set_font_size(cr2, 12)
  if pt['name'] == 'cpu' then
    cairo_move_to(cr2, xc - 14, yc + 45)
    cairo_show_text(cr2, string.format("%03.0f%s", t * 100, pt['suffix']))
    cairo_move_to(cr2, xc - 14 - 14, yc + 45 + 12)
    cairo_show_text(cr2, string.format("%s", cpu_freq_mean(4)))
  elseif pt['name'] == 'memperc' then
    cairo_move_to(cr2, xc - 14, yc + 45)
    cairo_show_text(cr2, string.format("%03.0f%s", t * 100, pt['suffix']))
    cairo_move_to(cr2, xc - 14 - 10, yc + 45 + 12)
    cairo_show_text(cr2, string.format("%03.2f GB", t * pt['real_max']))
  elseif pt['name'] == 'swapperc' then
    -- cairo_move_to(cr2, xc + 18, yc + 45)
    -- cairo_show_text(cr2, string.format(" / %03.0f%s", t * 100, pt['suffix']))
    -- cairo_move_to(cr2, xc + 18, yc + 45 + 12)
    -- cairo_show_text(cr2, string.format(" / %03.2f GB", t * 8))
  else
    cairo_move_to(cr2, xc - 14, yc + 45 + 6)
    cairo_show_text(cr2, string.format("%03.0f%s", t * 100, pt['suffix']))
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

function conky_render_bar()
  bg = conky_parse(
    '${exec jq .bar <  ~/.config/conky/MyMimosa/.cache/ref.json }')
  bg = bg:gsub('"', '')
  return string.format("${image %s -s %sx%s -p %s,%s}", bg, 1366, 42, 0, 0)
end

function conky_render_rss()
  bg = conky_parse(
    '${exec jq .rss <  ~/.config/conky/MyMimosa/.cache/ref.json }')
  bg = bg:gsub('"', '')
  return string.format("${image %s -s %sx%s -p %s,%s}", bg, 220, 250, 20, 100)
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
  bg = conky_parse(
    '${exec jq .main <  ~/.config/conky/MyMimosa/.cache/ref.json }')
  bg = bg:gsub('"', '')
  return string.format("${image %s -s %sx%s -p %s,%s}", bg, bg_width, bg_height, bg_pos_x, bg_pos_y)
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
  bg = conky_parse(
    '${exec jq .vert <  ~/.config/conky/MyMimosa/.cache/ref.json }')
  bg = bg:gsub('"', '')
  return string.format("${image %s -s %sx%s -p %s,%s}", bg, bg_vert_width, bg_vert_height, bg_pos_x,
    bg_pos_y)
end

function conky_render_calendar_bg()
  bg_calendar_height = bg_calendar_aspect * bg_calendar_width
  bg_pos_x = 0
  bg_pos_y = 0 + bg_calendar_padding_y
  if align_right then
    bg_pos_x = bg_calendar_padding_x
  else
    bg_pos_x = window_width - bg_calendar_width - bg_calendar_padding_x
  end
  bg = conky_parse(
    '${exec jq .calendar <  ~/.config/conky/MyMimosa/.cache/ref.json }')
  bg = bg:gsub('"', '')
  return string.format("${image %s -s %sx%s -p %s,%s}", bg, bg_calendar_width, bg_calendar_height,
    bg_pos_x, bg_pos_y)
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
  bg = conky_parse(
    '${exec jq .player <  ~/.config/conky/MyMimosa/.cache/ref.json }')
  bg = bg:gsub('"', '')
  return string.format("${image %s -s %sx%s -p %s,%s}", bg, bg_player_width, bg_player_height, bg_pos_x,
    bg_pos_y)
end

function conky_render_player_image(flag)
  if flag == "1" then
    banner = get_command_output("playerctl metadata mpris:artUrl| awk -F'file://' '{print $2}'")
  else
    banner = "~/.config/conky/MyMimosa/res/not-found.png"
  end
  bg_player_height = bg_player_aspect * bg_player_width
  bg_pos_x = 0 + bg_player_padding_x
  bg_pos_y = 0 + bg_player_padding_y + 20

  if align_right then
    bg_pos_x = bg_pos_x + window_width - bg_width - bg_player_width - bg_player_padding_x + player_img_padding_x
  else
    bg_pos_x = bg_player_width + bg_player_padding_x + player_img_padding_x
  end
  return string.format("${image %s -s %sx%s -p %s,%s}", banner, player_img_width, player_img_height, bg_pos_x,
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
    offset = window_width - bg_width - bg_player_width
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

counter = 0
function conky_rotate_text(text, limit)
  counter = counter + 1
  value = conky_parse(text)
  value_size = string.len(value)
  if value_size <= tonumber(limit) then
    return string.format("%s", value)
  end
  current = counter % value_size + 1
  p1 = string.sub(value, current, value_size)
  p2 = string.sub(value, 1, current)
  result = string.sub(string.format("%s - %s", p1, p2), 1, limit)
  return result
end

function cpu_freq_mean(number_cpus)
  value = 0.0
  for i = 1, number_cpus, 1 do
    value = value + tonumber(conky_parse(string.format('${freq %d}', i)))
  end
  return string.format("%.0f Mhz", value / number_cpus)
end

function conky_cpu_freq_mean(number_cpus)
  return cpu_freq_mean(number_cpus)
end

function conky_top_cpu(number)
  name = conky_parse(string.format("${top name %d}", number))
  value = conky_parse(string.format("${top cpu %d}", number))
  name = name:gsub("%s+", "")
  value = value:gsub("%s+", "")
  value = tonumber(value)
  if #name > 8 then
    name = string.sub(name, 1, 8)
  end
  name = lpad(name, 16, ' ')
  final = string.format("%05.2f %% %s", value, name)
  color = "${color}"
  font = "${font Roboto:size=8}"
  if value > 20 then
    color = "${color2}"
    font = "${font Roboto:bold:size=8}"
  end
  return conky_parse(font .. color .. final)
end

function conky_top_mem(number)
  name = conky_parse(string.format("${top_mem name %d}", number))
  value = conky_parse(string.format("${top_mem mem %d}", number))
  name = name:gsub("%s+", "")
  value = value:gsub("%s+", "")
  value = tonumber(value)
  if #name > 8 then
    name = string.sub(name, 1, 8)
  end
  name = lpad(name, 16, ' ')
  final = string.format("%05.2f %% %s", value, name)
  color = "${color}"
  font = "${font Roboto:size=8}"
  if value > 20 then
    color = "${color2}"
    font = "${font Roboto:bold:size=8}"
  end
  return conky_parse(font .. color .. final)
end

function conky_calendar()
  file = io.open('/tmp/conky-calendar', 'r')
  contents = file:read("*a")
  file:close()
  if align_right then
    offset = bg_calendar_padding_x + 20
  else
    offset = window_width - bg_calendar_width - bg_calendar_padding_x + 20
  end
  offset_str = string.format('${offset %d}${font Roboto:size=8}', offset)
  contents = string.gsub(contents, "offset|", offset_str)
  contents = string.gsub(contents, "bold|", "${font Roboto:bold:size=8} ")
  contents = offset_str ..
      "${font FiraCode Nerd Font:size=12}󰃭${font Roboto:bold:size=9}  Events\n${font Roboto:size=8}" .. contents
  return conky_parse(contents)
end

function lpad(str, len, char)
  char = char or ' ' -- Default character is space
  return string.rep(char, len - #str) .. str
end

function split_lines(str, regex)
  local lines = {}
  for line in str:gmatch(regex) do
    table.insert(lines, line)
  end
  return lines
end

function get_command_output(command)
  local handle = io.popen(command)
  local result = handle:read("*a") -- Read all output
  handle:close()
  return result
end
