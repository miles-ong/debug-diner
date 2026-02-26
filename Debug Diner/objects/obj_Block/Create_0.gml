type = BlockType.MOVE;
name = "";
color = BlockColor.WHITE;

parentBlock = noone;
nextBlock = noone;
childBlock = noone;

nextSlot = noone;
childSlot = noone;

isDraggable = true;
isSource = false;
hasSequence = true;
hasBody = false;

isDragging = false;

contents = [];

hoverStrength = 0.15;

function Initialize() {
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
			argDirection = AddContent(BlockContentType.ARGUMENT, BlockArgumentType.CYCLE, "", ["Left", "Right"]);
			break;
			
		case BlockType.LOOP:
			name = "Loop";
			SetBlockColor(BlockColor.RED);
			hasBody = true;
			
			AddContent(BlockContentType.BUTTON, BlockArgumentType.NONE, "-", [], function() {
				argCount.value = max(0, argCount.value - 1);
				OnArgumentChanged();
			});
			
			argCount = AddContent(BlockContentType.ARGUMENT, BlockArgumentType.INT);
			
			AddContent(BlockContentType.BUTTON, BlockArgumentType.NONE, "+", [], function() {
				argCount.value += 1;
				OnArgumentChanged();
			});
			
			AddContent(BlockContentType.DISPLAY, BlockArgumentType.NONE, "Times");
			
			break;
			
		case BlockType.IF:
			name = "If";
			SetBlockColor(BlockColor.WHITE);
			hasBody = true;
			condition = "";
			break;
	}
	
	sprite_index = hasBody ? spr_BlockBody : spr_Block;
	Stretch();
	
	if(hasSequence) {
		nextSlot = instance_create_layer(x, y + sprite_height, "BlockSlot", obj_BlockSlot);
		nextSlot.owner = id;
		nextSlot.type = SlotType.SEQUENCE;
	}
	
	if(hasBody) {
		childSlot = instance_create_layer(x + BLOCK_BODY_WIDTH, y + BLOCK_HEIGHT, "BlockSlot", obj_BlockSlot);
		childSlot.owner = id;
		childSlot.type = SlotType.BODY;
	}
}

function LinkToSlot(slot, mute = false) {
	if(slot == noone || !slot.isEmpty) return false;
	
	if(!mute) audio_play_sound(sfx_BlockConnect, 0, false);
	
	parentBlock = slot.owner;
		
	if(slot.type == SlotType.BODY) slot.owner.childBlock = id;
	else slot.owner.nextBlock = id;
	
	slot.isEmpty = false;
	x = slot.x;
	y = slot.y;
	
	StretchParents();
		
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
	
	StretchParents();
	
	parentBlock = noone;
}

function AddContent(_contentType, _argumentType = BlockArgumentType.NONE, _text = "", _options = [], _action = undefined) {
	var content = instance_create_layer(x, y, "BlockContent", obj_BlockContent);
	
	content.owner = id;
	content.contentType = _contentType;
	content.argumentType = _argumentType;
	content.options = _options;
	content.action = _action;
	
	content.Initialize(_text);
	
	array_push(contents, content);
	
	return content;
}

function OnArgumentChanged() {
	switch(type) {
		case BlockType.MOVE:
			break;
			
		case BlockType.TURN:
			turnDirection = argDirection.value;
			break;
		
		case BlockType.LOOP:
			count = argCount.value;
			break;
	}
	
	Stretch();
	RefreshChain();
}

function Stretch() {
	draw_set_font(fo_basic);
	var offsetX = BLOCK_EDGE_LENGTH + BLOCK_PADDING + sprite_get_width(spr_BlockLightConnected) + BLOCK_CONTENT_PADDING + string_width(name);
	
	for(var i = 0; i < array_length(contents); i++) {
		var content = contents[i];
		offsetX += BLOCK_CONTENT_PADDING;
		content.offsetX = offsetX;
		content.offsetY = (BLOCK_HEIGHT - BLOCK_CONTENT_HEIGHT) / 2;
		var contentWidth = content.GetValueWidth();
		
		if(content.contentType != BlockContentType.DISPLAY) content.image_xscale = contentWidth / BLOCK_CONTENT_WIDTH;
		
		offsetX += contentWidth;
	}
	
	var blockWidth = offsetX + BLOCK_CONTENT_PADDING + BLOCK_PADDING + BLOCK_EDGE_LENGTH;	
	image_xscale = blockWidth / sprite_get_width(sprite_index);
	
	if(hasBody) {
		var bodyHeight = 0;
		
		if(childBlock != noone) {
			var currentBlock = childBlock;
			
			while(currentBlock != noone) {
				bodyHeight += currentBlock.sprite_height;
				currentBlock = currentBlock.nextBlock;
			}
		}
		
		image_yscale = (bodyHeight + sprite_get_height(spr_BlockBody)) / sprite_get_height(sprite_index);
	}
	
	RefreshChain();
}

function StretchParents() {
	var current = parentBlock;
	
	while(current != noone) {
		if(current.hasBody) current.Stretch();
		
		current = current.parentBlock;
	}
}

function RefreshChain() {	
	for(var i = 0; i < array_length(contents); i++) {
		contents[i].x = x + contents[i].offsetX;
		contents[i].y = y + contents[i].offsetY;
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

function DestroyChain() {
	for(var i = 0; i < array_length(contents); i++) {
		instance_destroy(contents[i]);
	}
	
	if(childBlock != noone) childBlock.DestroyChain();
	if(nextBlock != noone) nextBlock.DestroyChain();
	if(nextSlot != noone) instance_destroy(nextSlot);
	if(childSlot != noone) instance_destroy(childSlot);
	
	instance_destroy();
}

function BringToDraggingLayer() {
	layer = layer_get_id("BlockDragging");
	
	for(var i = 0; i < array_length(contents); i++) {
		contents[i].layer = layer_get_id("BlockContentDragging");
	}
	
	if(nextSlot != noone) nextSlot.layer = layer_get_id("BlockSlotDragging");
	if(childSlot != noone) childSlot.layer = layer_get_id("BlockSlotDragging");
	if(nextBlock != noone) nextBlock.BringToDraggingLayer();
	if(childBlock != noone) childBlock.BringToDraggingLayer();
}

function BringToBaseLayer() {
	layer = layer_get_id("Block");
	
	for(var i = 0; i < array_length(contents); i++) {
		contents[i].layer = layer_get_id("BlockContent");
	}
	
	if(nextSlot != noone) nextSlot.layer = layer_get_id("BlockSlot");
	if(childSlot != noone) childSlot.layer = layer_get_id("BlockSlot");
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
			node.args.turnDirection = argDirection.value;
			break;
			
		case BlockType.LOOP:
			node.args.count = argCount.value;
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
	Initialize();
	
	switch(type) {
		case BlockType.MOVE:
			break;
			
		case BlockType.TURN:
			turnDirection = node.args.turnDirection;
			argDirection.value = turnDirection;
			break;
			
		case BlockType.LOOP:
			count = node.args.count;
			argCount.value = count;
			break;
	}
	
	Stretch();
	
	var previousBlock = noone;
	
	for(var i = 0; i < array_length(node.body); i++) {
		var child = instance_create_layer(childSlot.x, childSlot.y, "Block", obj_Block);
		child.Deserialize(node.body[i]);
		
		if(previousBlock == noone) child.LinkToSlot(childSlot, true);
		else child.LinkToSlot(previousBlock.nextSlot, true);
		
		previousBlock = child;
	}
}