if (array_length(dialog) <= 0) exit;

var w = display_get_gui_width();
var h = display_get_gui_height();

var line = dialog[idx];

var x1 = margin;
var y1 = h - box_h - margin;
var x2 = w - margin;
var y2 = h - margin;

draw_set_alpha(0.85);
draw_set_color(make_color_rgb(15, 15, 15));
draw_roundrect(x1, y1, x2, y2, false);

draw_set_alpha(1);
draw_set_color(c_white);
if (asset_get_type(font_name) != -1) draw_set_font(font_name);
draw_text(x1 + padding, y1 + padding, line.name);

if (asset_get_type(font_text) != -1) draw_set_font(font_text);
draw_text_ext(x1 + padding, y1 + padding + 44, line.text, 24, (x2 - x1) - padding*2);

draw_set_alpha(0.75);
draw_text(x2 - 230, y2 - 40, "[Space/Click] Next");
draw_set_alpha(1);