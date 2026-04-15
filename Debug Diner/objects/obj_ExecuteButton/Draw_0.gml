event_inherited();

if(global.gameState == GameState.EXECUTING || global.gameState == GameState.READING) {
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, resetColor, hoverStrength);
}
else {
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, startColor, hoverStrength);
	draw_sprite_ext(spr_Start, 0, x, y, 1, 1, 0, c_white, hoverStrength);
}

if(highlight) shader_reset();