draw_self();

draw_set_color(c_white);
draw_set_font(fo_UIMedium);
var text = global.currentLevel.name;
var nameWidth = string_width(text);
var textPaddingX = nameWidth / 2;
var textPaddingY = (sprite_height - string_height("A")) / 2;

draw_text(x - textPaddingX, y - textPaddingY, text);