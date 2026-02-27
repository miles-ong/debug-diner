var tint = isDraggable && global.hoveredBlock == id ? merge_color(color, c_black, hoverStrength) : color;

draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, tint, 1);

var lightSprite = parentBlock != noone || isSource ? spr_BlockLightConnected : spr_BlockLightDisconnected;
var lightPaddingX = BLOCK_EDGE_LENGTH + BLOCK_PADDING;
var lightPaddingY = (BLOCK_HEIGHT - sprite_get_height(lightSprite)) / 2;

draw_sprite(lightSprite, 0, x + lightPaddingX, y + lightPaddingY);

draw_set_color(c_black);
draw_set_font(fo_UISmall);
var textPaddingX = lightPaddingX + sprite_get_width(spr_BlockLightConnected) + BLOCK_CONTENT_PADDING;
var textPaddingY = ((BLOCK_HEIGHT + BLOCK_EDGE_LENGTH) - string_height("A")) / 2;

draw_text(x + textPaddingX, y + textPaddingY, name);