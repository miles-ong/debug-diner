function Initialize(_enabledBlocks) {
	var xPadding = x + UI_CONTAINER_PADDING * 2 + 16;
	var yPadding = y + sprite_height / 2;
	
	for(var i = 0; i < array_length(_enabledBlocks); i++) {
		var button = BuildButton(_enabledBlocks[i], xPadding, yPadding);
		xPadding += button.sprite_width + BLOCK_BANK_CONTENT_PADDING;
	}
}

function BuildButton(_blockType, _x, _y) {
	var name;
	var color;
	var hasBody = false;
	
	switch(_blockType) {
		case BlockType.MOVE:
			name = "Move";
			color = BlockColor.BLUE;
			break;
			
		case BlockType.TURN: 
			name = "Turn";
			color = BlockColor.ORANGE;
			break;
			
		case BlockType.LOOP: 
			name = "Loop";
			color = BlockColor.RED;
			hasBody = true;
			break;
	}
	
	var blockHeight = hasBody ? sprite_get_height(spr_BlockBody) : sprite_get_height(spr_Block);
	var button = instance_create_layer(_x, _y - blockHeight / 2, "LevelInterface", obj_BlockButton);
	button.Initialize(_blockType, name, color, hasBody);
	
	return button;
}