if (!show_tooltip) exit;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var title_str = string(tooltip_title);
var text_str  = string(tooltip_text);

var pad = 10;
var line_gap = 6;
var box_max_width = 260;

// 用默认字体测试
draw_set_font(-1);

var title_w = string_width(title_str);
var title_h = string_height(title_str);

var text_w = min(box_max_width, string_width_ext(text_str, 18, box_max_width));
var text_h = string_height_ext(text_str, 18, box_max_width);

var box_w = max(title_w, text_w) + pad * 2;
var box_h = pad + title_h + line_gap + text_h + pad;

// 默认显示在鼠标右下角
var box_x = mx + 16;
var box_y = my + 16;

// 防止超出屏幕
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

if (box_x + box_w > gui_w) box_x = mx - box_w - 16;
if (box_y + box_h > gui_h) box_y = my - box_h - 16;

// 背景
draw_set_alpha(0.9);
draw_set_color(make_color_rgb(18, 22, 30));
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, false);

// 边框
draw_set_alpha(1);
draw_set_color(make_color_rgb(80, 220, 255));
draw_rectangle(box_x, box_y, box_x + box_w, box_y + box_h, true);

// 标题
draw_set_color(c_white);
draw_text(box_x + pad, box_y + pad, title_str);

// 正文
draw_set_color(make_color_rgb(220, 220, 220));
draw_text_ext(box_x + pad, box_y + pad + title_h + line_gap, text_str, 18, box_max_width);