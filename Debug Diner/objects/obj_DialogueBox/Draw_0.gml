var guiW = display_get_gui_width();
var guiH = display_get_gui_height();
var spriteW = characterSprite != noone ? sprite_get_width(characterSprite) : 0;
var spriteH = characterSprite != noone ? sprite_get_height(characterSprite) : 0; 
var boxY = guiH - contentPadding - boxHeight;
var charX, boxX, boxW;

if(position == DialoguePosition.LEFT) {
	charX = contentPadding + spriteW / 2;
	boxX = charX + spriteW / 2 + contentPadding;
	boxW = (guiW - contentPadding) - boxX;
	draw_sprite_stretched(sprite_index, 0, boxX, boxY, boxW, boxHeight);
	
	if(characterSprite != noone) draw_sprite(characterSprite, 0, charX, guiH);
}
else {
	charX = guiW - contentPadding - spriteW / 2;
	boxX = contentPadding;
	boxW = charX - spriteW / 2 - contentPadding * 2;
	draw_sprite_stretched(sprite_index, 0, boxX, boxY, boxW, boxHeight);
	
	if(characterSprite != noone) draw_sprite(characterSprite, 0, charX, guiH);
}

draw_set_font(textFont);
draw_set_color(c_black);
draw_text_ext(boxX + textPadding, boxY + textPadding, currentText, -1, boxW - textPadding * 2);