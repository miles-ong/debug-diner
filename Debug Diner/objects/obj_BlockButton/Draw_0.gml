draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, color, 1);

draw_set_color(c_black);
draw_set_font(fo_UISmall);
var paddingX = BLOCK_EDGE_LENGTH + BLOCK_PADDING + BLOCK_CONTENT_PADDING;
var paddingY = ((BLOCK_HEIGHT + BLOCK_EDGE_LENGTH) - string_height("A")) / 2;

draw_text(x + paddingX, y + paddingY, name);