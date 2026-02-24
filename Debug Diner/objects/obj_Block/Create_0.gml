type = BlockType.MOVE;
name = "";
color = BlockColor.WHITE;
parentBlock = noone;
nextBlock = noone;
childBlock = noone;
isDragging = false;
isDraggable = true;
isSource = false;
hasSequence = true;
hasBody = false;
hasArguments = false;
nextSlot = noone;
childSlot = noone;
args = [];

hoverStrength = 0.15;

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
			name = "Program";
			SetBlockColor(BlockColor.PURPLE);
			isDraggable = false;
			isSource = true;
			break;
			
		case BlockType.MOVE:
			name = "Move Forward";
			SetBlockColor(BlockColor.BLUE);
			break;
			
		case BlockType.TURN:
			name = "Turn";
			SetBlockColor(BlockColor.ORANGE);
			hasArguments = true;
			turnDirection = TurnDirection.LEFT;
			AddArgument(ArgumentType.DROPDOWN, ["Left", "Right"]);
			break;
			
		case BlockType.IF:
			name = "If";
			SetBlockColor(BlockColor.WHITE);
			hasArguments = true;
			hasBody = true;
			condition = "";
			break;
	}
	
	Stretch();
	
	if(hasArguments) OnArgumentChanged();
	
	if(hasSequence) {
		nextSlot = instance_create_layer(x, y + sprite_height, "SlotLayer", obj_BlockSlot);
		nextSlot.owner = id;
		nextSlot.type = SlotType.SEQUENCE;
	}
	
	if(hasBody) {
		childSlot = instance_create_layer(x + BLOCK_BODY_WIDTH, y + BLOCK_HEIGHT, "SlotLayer", obj_BlockSlot);
		childSlot.owner = id;
		childSlot.type = SlotType.BODY;
	}
}

function LinkToSlot(slot) {
	if(slot == noone || !slot.isEmpty) return false;
	
	audio_play_sound(sfx_BlockConnect, 0, false);
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
	
	audio_play_sound(sfx_BlockDisconnect, 0, false);
	
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
			break;
			
		case BlockType.TURN:
			turnDirection = args[0].value;
			break;
	}
	
	Stretch();
	RefreshChain();
}

function Stretch() {
	draw_set_font(fo_basic);
	var offsetX = BLOCK_EDGE_LENGTH + BLOCK_PADDING + sprite_get_width(spr_BlockLightConnected) + BLOCK_CONTENT_PADDING + string_width(name);
	
	for(var i = 0; i < array_length(args); i++) {
		var arg = args[i];
		offsetX += BLOCK_CONTENT_PADDING;
		arg.offsetX = offsetX;
		arg.offsetY = (BLOCK_HEIGHT - arg.sprite_height) / 2;
		var argWidth = arg.GetValueWidth();
		arg.image_xscale = argWidth / sprite_get_width(arg.sprite_index);
		offsetX += argWidth;
	}
	
	var stretchLength = offsetX + BLOCK_CONTENT_PADDING + BLOCK_PADDING + BLOCK_EDGE_LENGTH;	
	image_xscale = stretchLength / sprite_get_width(sprite_index);
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

function BringToDraggingLayer() {
	layer = layer_get_id("BlockDraggingLayer");
	
	if(nextSlot != noone) nextSlot.layer = layer_get_id("SlotDraggingLayer");
	if(childSlot != noone) childSlot.layer = layer_get_id("SlotDraggingLayer");
	
	for(var i = 0; i < array_length(args); i++) {
		args[i].layer = layer_get_id("ArgumentsDraggingLayer");
	}
	
	if(nextBlock != noone) nextBlock.BringToDraggingLayer();
	if(childBlock != noone) childBlock.BringToDraggingLayer();
}

function BringToBaseLayer() {
	layer = layer_get_id("BlockLayer");
	
	if(nextSlot != noone) nextSlot.layer = layer_get_id("SlotLayer");
	if(childSlot != noone) childSlot.layer = layer_get_id("SlotLayer");
	
	for(var i = 0; i < array_length(args); i++) {
		args[i].layer = layer_get_id("ArgumentsLayer");
	}
	
	if(nextBlock != noone) nextBlock.BringToBaseLayer();
	if(childBlock != noone) childBlock.BringToBaseLayer();
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
			args[0].value = turnDirection;
			break;
	}
	
	Stretch();
	
	var previousBlock = noone;
	
	for(var i = 0; i < array_length(node.body); i++) {
		var child = instance_create_layer(childSlot.x, childSlot.y, "BlockLayer", obj_Block);
		child.Deserialize(node.body[i]);
		
		if(previousBlock == noone) child.LinkToSlot(childSlot);
		else child.LinkToSlot(previousBlock.nextSlot);
		
		previousBlock = child;
	}
}