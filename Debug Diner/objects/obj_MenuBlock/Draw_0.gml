draw_self();

draw_set_color(c_white);
draw_set_font(fo_UIMedium);
var textPaddingX = MENU_BLOCK_EDGE_LENGTH + MENU_BLOCK_TEXT_PADDING;
var textPaddingY = ((MENU_BLOCK_HEIGHT + MENU_BLOCK_EDGE_LENGTH) - string_height("A")) / 2;

draw_text(x + textPaddingX, y + textPaddingY, name);