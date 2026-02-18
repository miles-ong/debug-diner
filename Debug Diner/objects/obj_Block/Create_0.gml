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
	
	nextSlot = noone;
	childSlot = noone;
	
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
	
	nextSlot = instance_create_layer(x, y + sprite_height, "GameInterface", obj_BlockSlot);
	nextSlot.owner = id;
	
	if(hasBody) {
		childSlot = instance_create_layer(x + BLOCK_BODY_WIDTH, y + BLOCK_HEIGHT, "GameInterface", obj_BlockSlot);
		childSlot.owner = id;
		childSlot.type = SlotType.BODY;
	}
}

function LinkToSlot(slot) {
	if(slot == noone || !slot.isEmpty) return false;
	if(IsInChain(slot.owner)) return false;
	
	parentBlock = slot.owner;
		
	if(slot.type == SlotType.BODY) slot.owner.childBlock = id;
	else slot.owner.nextBlock = id;
		
	slot.isEmpty = false;
	x = slot.x;
	y = slot.y;
		
	return true;
}

function UnlinkFromSlot() {
	if(parentBlock == noone) return;
	
	if(parentBlock.nextBlock == id) {
		parentBlock.nextBlock = noone;
		
		if(parentBlock.nextSlot != noone) parentBlock.nextSlot.isEmpty = true;
	}
	
	if(parentBlock.childBlock == id) {
		parentBlock.childBlock = noone;
		
		if(parentBlock.childSlot != noone) parentBlock.childSlot.isEmpty = true;
	}
	
	parentBlock = noone;
}

function IsInChain(block) {
    if(block == id) return true;
    if(nextBlock != noone && nextBlock.IsInChain(block)) return true;
    if(childBlock != noone && childBlock.IsInChain(block)) return true;
	
    return false;
}

function RefreshChain() {
	if(nextSlot != noone) {
		nextSlot.x = x;
		nextSlot.y = y + sprite_height;
	}
	
	if(childSlot != noone) {
		childSlot.x = x + BLOCK_BODY_WIDTH;
		childSlot.y = y + BLOCK_HEIGHT;
	}
	
	if(nextBlock != noone) {
		nextBlock.x = x;
		nextBlock.y = y + sprite_height;
		nextBlock.RefreshChain();
	}
	
	if(childBlock != noone) {
		childBlock.x = x + BLOCK_BODY_WIDTH;
		childBlock.y = y + BLOCK_HEIGHT;
		childBlock.RefreshChain();
	}
}

function MoveChain(xx, yy) {
	x = xx;
	y = yy;
	RefreshChain();
}

function DestroyChain() {
	if(childBlock != noone) childBlock.DestroyChain();
	if(nextBlock != noone) nextBlock.DestroyChain();
	if(nextSlot != noone) instance_destroy(nextSlot);
	if(childSlot != noone) instance_destroy(childSlot);
	instance_destroy();
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
	
	if(hasBody) {
		var child = childBlock;
		
		while(child != noone) {
			array_push(node.body, child.Serialize());
			child = child.nextBlock;
		}
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
	
	var previousBlock = noone;
	
	for(var i = 0; i < array_length(node.body); i++) {
		var child = instance_create_layer(childSlot.x, childSlot.y, "GameInterface", obj_Block);
		child.Deserialize(node.body[i]);
		
		if(previousBlock == noone) child.LinkToSlot(childSlot);
		else child.LinkToSlot(previousBlock.nextSlot);
		
		previousBlock = child;
	}
}