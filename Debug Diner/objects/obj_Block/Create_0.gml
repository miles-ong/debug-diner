type = "";
parentBlock = noone;
nextBlock = noone;
childBlock = noone;
isDragging = false;
isDraggable = true;
hasBody = false;
hasArguments = false;
nextSlot = noone;
childSlot = noone;

function SetupType() {
	if(nextSlot != noone) {
		instance_destroy(nextSlot);
	}
	
	if(childSlot != noone) {
		instance_destroy(childSlot);
	}
	
	nextSlot = instance_create_layer(x, y + sprite_height, "GameInterface", obj_BlockSlot);
	nextSlot.owner = id;
	
	switch(type) {
		case BlockType.PROGRAM:
			isDraggable = false;
			break;
			
		case BlockType.MOVE:
			break;
			
		case BlockType.TURN:
			hasArguments = true;
			turnDirection = TurnDirection.LEFT;
			break;
			
		case BlockType.IF:
			hasArguments = true;
			hasBody = true;
			condition = "";
			break;
	}
	
	if(hasBody) {
		childSlot = instance_create_layer(x + BLOCK_BODY_WIDTH, y + BLOCK_HEIGHT, "GameInterface", obj_BlockSlot);
		childSlot.owner = id;
		childSlot.type = SlotType.BODY;
	}
}

function LinkToSlot(slot) {
	if(slot != noone && slot.isEmpty) {
		parentBlock = slot.owner;
		
		if(slot.type == SlotType.BODY) {
			slot.owner.childBlock = id;
		}
		else {
			slot.owner.nextBlock = id;
		}
		
		slot.isEmpty = false;
		
		x = slot.x;
		y = slot.y;
		
		return true;
	}
	
	return false;
}

function UnlinkFromSlot() {
	if(parentBlock == noone) {
		return;
	}
	
	if(parentBlock.nextBlock == id) {
		parentBlock.nextBlock = noone;
		parentBlock.nextSlot.isEmpty = true;
	}
	
	if(parentBlock.childBlock == id) {
		parentBlock.childBlock = noone;
		parentBlock.childSlot.isEmpty = true;
	}
	
	parentBlock = noone;
}

function Serialize() {
	var node = {
		type : type,
		args : {},
		body : []
	}
	
	switch(type) {
		case BlockType.MOVE:
			break;
			
		case BlockType.TURN:
			node.args.turnDirection = turnDirection;
			break;
	}
	
	return node;
}

function Deserialize(node) {
	type = node.type;
	SetupType();
	
	switch(type) {
		case BlockType.MOVE:
			break;
			
		case BlockType.TURN:
			turnDirection = node.args.turnDirection;
			break;
	}
}