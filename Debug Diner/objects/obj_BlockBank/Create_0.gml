function Initialize(_enabledBlocks) {
	with(obj_BlockButton) instance_destroy(id);
	
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
	var isConditional = false;
	
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
		
		case BlockType.IF:
			name = "If";
			color = BlockColor.TEAL;
			hasBody = true;
			break;
		
		case BlockType.WHILE:
			name = "While";
			color = BlockColor.CYAN;
			hasBody = true;
			break;
		
		case BlockType.WAIT:
			name = "Wait";
			color = BlockColor.PINK;
			break;
		
		case BlockType.INTERACT:
			name = "Interact";
			color = BlockColor.WHITE;
			break;
		
		case BlockType.DEFINE:
			name = "Define";
			color = BlockColor.GRAPE;
			break;
		
		case BlockType.CALL:
			name = "Call";
			color = BlockColor.SLATE;
			break;
		
		case BlockType.COND_AHEAD_IS:
			name = "Ahead Is";
			color = BlockColor.GREEN;
			isConditional = true;
			break;
	}

	var blockHeight;
	
	if(isConditional) blockHeight = sprite_get_height(spr_ConditionalBlock);
	else blockHeight = hasBody ? sprite_get_height(spr_BlockBody) : sprite_get_height(spr_Block);
	
	var button = instance_create_layer(_x, _y - blockHeight / 2, "LevelInterface", obj_BlockButton);
	button.Initialize(_blockType, name, color, hasBody, isConditional);
	
	return button;
}