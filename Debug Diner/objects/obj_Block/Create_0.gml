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
args = [];

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
			sprite_index = spr_ProgramBlock;
			isDraggable = false;
			break;
			
		case BlockType.MOVE:
			sprite_index = spr_MoveBlock;
			hasArguments = true;
			tiles = 1;
			AddArgument(ArgumentType.INT);
			break;
			
		case BlockType.TURN:
			sprite_index = spr_TurnBlock;
			hasArguments = true;
			turnDirection = TurnDirection.LEFT;
			AddArgument(ArgumentType.DROPDOWN, ["Left", "Right"]);
			break;
			
		case BlockType.IF:
			hasArguments = true;
			hasBody = true;
			condition = "";
			break;
	}
	
	if(hasArguments) OnArgumentChanged();
	
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

function AddArgument(argType, options = []) {
	var arg = instance_create_layer(x, y, "ArgumentsLayer", obj_BlockArgument);
	arg.owner = id;
	arg.type = argType;
	arg.options = options;
	arg.SetupType();
	array_push(args, arg);
	
	return arg;
}

function OnArgumentChanged() {
	switch(type) {
		case BlockType.MOVE:
			tiles = args[0].value;
			break;
			
		case BlockType.TURN:
			turnDirection = args[0].value;
			break;
	}
	
	var slice = sprite_get_nineslice(sprite_index);
	var offsetX = slice.left;
	
	for(var i = 0; i < array_length(args); i++) {
		var arg = args[i];
		arg.offsetX = offsetX;
		arg.offsetY = (sprite_height - arg.sprite_height) / 2;
		arg.image_xscale = arg.GetValueWidth() / arg.sprite_width;
		offsetX += arg.GetValueWidth();
	}
	
	var totalWidth = max(sprite_width, offsetX + slice.right);
	image_xscale = totalWidth / sprite_width;
	
	RefreshChain();
}

function RefreshChain() {	
	for(var i = 0; i < array_length(args); i++) {
		args[i].x = x + args[i].offsetX;
		args[i].y = y + args[i].offsetY;
	}
	
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
	for(var i = 0; i < array_length(args); i++) {
		instance_destroy(args[i]);
	}
	
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
			node.args.tiles = tiles;
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
			tiles = node.args.tiles;
			args[0].value = tiles;
			break;
			
		case BlockType.TURN:
			turnDirection = node.args.turnDirection;
			args[0].value = turnDirection;
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