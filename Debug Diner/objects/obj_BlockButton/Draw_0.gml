draw_sprite_ext(spr_Block, 0, x, y, image_xscale, image_yscale, 0, color, 1);

var height = BLOCK_HEIGHT * image_yscale;
var paddingX = BLOCK_EDGE_LENGTH + BLOCK_PADDING + BLOCK_CONTENT_PADDING;
var paddingY = (height - string_height("A")) / 2;
draw_set_color(c_black);
draw_set_font(fo_basic);
draw_text(x + paddingX, y + paddingY, name);