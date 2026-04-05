if (!show_tooltip) exit;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var title_str = string(tooltip_title);
var text_str  = string(tooltip_text);

// 这里假设你已经有字体
var f_title = fnt_dialog_name; 
var f_text  = fnt_dialog_text;

// ===== 计算宽高 =====
draw_set_font(f_title);
var title_w = string_width(title_str);
var title_h = string_height(title_str);

draw_set_font(f_text);
var text_w = min(box_max_width, max(180, string_width_ext(text_str, -1, box_max_width)));
var text_h = string_height_ext(text_str, 22, box_max_width);

var box_w = max(title_w, text_w) + pad * 2;
var box_h = pad + title_h + line_gap + text_h + pad;

// 默认显示在鼠标右下角
var box_x = mx + 20;
var box_y = my + 20;

// 防止超出屏幕
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

if (box_x + box_w > gui_w) box_x = mx - box_w - 20;
if (box_y + box_h > gui_h) box_y = my - box_h - 20;

// ===== 画背景 =====
draw_set_alpha(0.92);
draw_set_color(bg_color);
draw_roundrect(box_x, box_y, box_x + box_w, box_y + box_h, false);

draw_set_alpha(1);
draw_set_color(border_color);
draw_roundrect(box_x, box_y, box_x + box_w, box_y + box_h, true);

// ===== 画标题 =====
draw_set_font(f_title);
draw_set_color(title_color);
draw_text(box_x + pad, box_y + pad, title_str);

// ===== 画正文 =====
draw_set_font(f_text);
draw_set_color(text_color);
draw_text_ext(box_x + pad, box_y + pad + title_h + line_gap, text_str, 22, box_max_width);