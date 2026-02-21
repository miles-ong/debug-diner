type = BlockType.MOVE;
name = "";

image_speed = 0;

function Stretch() {
	var slice = sprite_get_nineslice(sprite_index);
	draw_set_font(fo_basic);
	var offsetX = string_width(name) + BLOCK_PADDING * 2;
	var totalWidth = max(sprite_get_width(sprite_index), offsetX + slice.right);
	image_xscale = totalWidth / sprite_get_width(sprite_index);
}