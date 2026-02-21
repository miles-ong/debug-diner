draw_self();

var height = BLOCK_HEIGHT * image_yscale;
var paddingY = (height - string_height("A")) / 2;
draw_set_color(c_black);
draw_set_font(fo_basic);
draw_text(x + BLOCK_PADDING, y + paddingY, name);