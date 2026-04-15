var guiW = display_get_gui_width();
var guiH = display_get_gui_height();
var spriteW = characterSprite != noone ? sprite_get_width(characterSprite) : 0;
var spriteH = characterSprite != noone ? sprite_get_height(characterSprite) : 0; 
var boxY = guiH - contentPadding - boxHeight;
var charX, boxX, boxW;

if(position == Position.LEFT) {
	charX = contentPadding + spriteW / 2;
	boxX = charX + spriteW / 2 + contentPadding;
	boxW = (guiW - contentPadding) - boxX;
	draw_sprite_stretched_ext(sprite_index, 0, boxX, boxY, boxW, boxHeight, color, 1);
	
	if(characterSprite != noone) draw_sprite_ext(characterSprite, 0, charX, guiH, -1, 1, 0, c_white, 1);
}
else {
	charX = guiW - contentPadding - spriteW / 2;
	boxX = contentPadding;
	boxW = charX - spriteW / 2 - contentPadding * 2;
	draw_sprite_stretched_ext(sprite_index, 0, boxX, boxY, boxW, boxHeight, color, 1);
	
	if(characterSprite != noone) draw_sprite(characterSprite, 0, charX, guiH);
}

draw_set_font(textFont);
draw_set_color(c_black);
draw_text_ext(boxX + textPadding, boxY + textPadding, currentText, -1, boxW - textPadding * 2);

var hintX = boxX + boxW - textPadding - hintW;
var hintY = boxY + boxHeight - textPadding - hintH;
draw_set_font(fo_UIMedium);
draw_set_alpha(hintAlpha);
draw_text(hintX, hintY, hint);
draw_set_alpha(1);