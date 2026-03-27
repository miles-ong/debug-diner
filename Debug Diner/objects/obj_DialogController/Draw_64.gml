if (!is_array(dialog)) exit;
if (array_length(dialog) <= 0) exit;
if (idx < 0 || idx >= array_length(dialog)) exit;

var w = display_get_gui_width();
var h = display_get_gui_height();

var line = dialog[idx];

var line_side = "L";
var line_name = "";
var line_text = "";
var line_sprite = noone;

if (variable_struct_exists(line, "side"))   line_side = line.side;
if (variable_struct_exists(line, "name"))   line_name = line.name;
if (variable_struct_exists(line, "text"))   line_text = line.text;
if (variable_struct_exists(line, "sprite")) line_sprite = line.sprite;

var margin = DIALOG_MARGIN;
var bottom_margin = DIALOG_BOTTOM_MARGIN;
var box_h = DIALOG_BOX_HEIGHT;
var padding = DIALOG_PADDING;

var portrait_area_w = DIALOG_PORTRAIT_AREA_WIDTH;
var gap = DIALOG_PORTRAIT_GAP;
var portrait_scale = DIALOG_PORTRAIT_SCALE;

var y_bottom = h - bottom_margin;
var y_top = y_bottom - box_h;

var portrait_x = 0;
var portrait_y = y_bottom;

var box_x1 = 0;
var box_x2 = 0;

var portrait_left = 0;
var portrait_right = 0;

if (line_side == "L") {
    portrait_left = margin;
    portrait_right = margin + portrait_area_w;
    portrait_x = portrait_left + portrait_area_w * 0.5;

    box_x1 = margin + portrait_area_w + gap;
    box_x2 = w - margin;
}
else {
    portrait_left = w - margin - portrait_area_w;
    portrait_right = w - margin;
    portrait_x = portrait_left + portrait_area_w * 0.5;

    box_x1 = margin;
    box_x2 = w - margin - portrait_area_w - gap;
}

draw_set_alpha(DIALOG_BOX_ALPHA);
draw_set_color(make_color_rgb(15, 15, 15));
draw_roundrect(box_x1, y_top, box_x2, y_bottom, false);

draw_set_alpha(1);
draw_set_color(c_white);

if (!is_undefined(line_sprite) && line_sprite != noone) {
    var xscale = portrait_scale;

    if (line_side == "R") {
        xscale = -portrait_scale;
    }

    draw_sprite_ext(
        line_sprite,
        0,
        portrait_x,
        portrait_y,
        xscale,
        portrait_scale,
        0,
        c_white,
        1
    );
}

draw_set_alpha(1);
draw_set_font(DIALOG_FONT_NAME);
draw_set_color(c_white);
draw_text(
    box_x1 + padding,
    y_top + padding + DIALOG_NAME_OFFSET_Y,
    string(line_name)
);

draw_set_font(DIALOG_FONT_TEXT);
draw_text_ext(
    box_x1 + padding,
    y_top + padding + DIALOG_TEXT_OFFSET_Y,
    string(line_text),
    DIALOG_LINE_SPACING,
    (box_x2 - box_x1) - padding * 2
);

draw_set_alpha(0.7);
draw_text(
    box_x2 - DIALOG_NEXT_OFFSET_X,
    y_bottom - DIALOG_NEXT_OFFSET_Y,
    "[Next]"
);

draw_set_alpha(1);
draw_set_color(c_white);