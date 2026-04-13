draw_self();
draw_set_alpha(image_alpha);

draw_set_color(c_white);
draw_set_font(fo_UIMedium);

var text = global.currentLevel.unlocked
	? global.currentLevel.name
	: "Locked";
	
var nameWidth = string_width(text);
var textPaddingX = nameWidth / 2;
var textPaddingY = (sprite_height - string_height("A")) / 2;

draw_text(x - textPaddingX, y - textPaddingY, text);
draw_set_alpha(1);