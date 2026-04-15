event_inherited();

var tint = isDraggable && global.hoveredBlock == id ? merge_color(color, c_black, hoverStrength) : color;
draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, tint, 1);

var lightSprite;

if(isDraggable) lightSprite = parentBlock != noone || isSource ? spr_BlockLightConnected : spr_BlockLightDisconnected;
else lightSprite = spr_BlockLightUndraggable;

var lightPaddingX = BLOCK_EDGE_LENGTH + BLOCK_PADDING;
var lightPaddingY = (BLOCK_HEIGHT - sprite_get_height(lightSprite)) / 2;

if(!isConditional) draw_sprite(lightSprite, 0, x + lightPaddingX, y + lightPaddingY);

draw_set_color(c_black);
draw_set_font(fo_UISmall);

var textPaddingX;
var textPaddingY;

if(isConditional) {
	textPaddingX = BLOCK_CONTENT_PADDING;
	textPaddingY = ((CONDITIONAL_BLOCK_HEIGHT + BLOCK_EDGE_LENGTH) - string_height("A")) / 2;
}
else {
	textPaddingX = lightPaddingX + sprite_get_width(spr_BlockLightConnected) + BLOCK_CONTENT_PADDING;
	textPaddingY = ((BLOCK_HEIGHT + BLOCK_EDGE_LENGTH) - string_height("A")) / 2;
}

draw_text(x + textPaddingX, y + textPaddingY, name);

if(hasElse) {
	draw_sprite_ext(spr_ElseBlockBody, 0, x, y + sprite_height - BLOCK_HEIGHT, image_xscale, elseBodyYScale, 0, tint, 1);
	draw_text(x + lightPaddingX + sprite_get_width(spr_BlockLightConnected) + BLOCK_CONTENT_PADDING, y + textPaddingY + sprite_height - BLOCK_HEIGHT, "Else Do");
}

if(highlight) shader_reset();