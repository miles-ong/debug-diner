type = BlockType.MOVE;
name = "";
color = BlockColor.WHITE;

function Initialize(_type, _name, _color, _hasBody = false) {
	type = _type;
	name = _name;
	sprite_index = _hasBody ? spr_BlockBody : spr_Block;
	SetBlockColor(_color);
	Stretch();
}

function Stretch() {
	draw_set_font(fo_UISmall);
	var stretchLength = BLOCK_EDGE_LENGTH * 2 + BLOCK_PADDING * 2 + BLOCK_CONTENT_PADDING * 2 + string_width(name);
	image_xscale = stretchLength / sprite_get_width(sprite_index);
}