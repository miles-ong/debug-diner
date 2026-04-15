event_inherited();

type = BlockType.MOVE;
name = "";
color = BlockColor.WHITE;

parentBlock = noone;
nextBlock = noone;
childBlock = noone;
conditionBlock = noone;
elseBlock = noone;
elseBodyYScale = 1;

nextSlot = noone;
childSlot = noone;
conditionSlot = noone;
elseSlot = noone;

isDraggable = true;
isSource = false;
hasSequence = true;
hasBody = false;
hasElse = false;
isConditional = false;

argDo = noone;
argElseToggle = noone;

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
			SetBlockColor(BlockColor.TEAL);
			hasBody = true;
			hasElse = false;
			condition = "";
			argDo = AddContent(BlockContentType.DISPLAY, BlockArgumentType.NONE, "Do");
			argElseToggle = AddContent(BlockContentType.BUTTON, BlockArgumentType.NONE, hasElse ? "- Else" : "+ Else", [], function() {
				hasElse = !hasElse;
				
				if(hasElse) {
				    elseSlot = instance_create_layer(x + BLOCK_BODY_WIDTH, y, "BlockSlot", obj_BlockSlot);
				    elseSlot.owner = id;
				    elseSlot.type = SlotType.ELSE;
				    argElseToggle.text = "- Else";
				}
				else {
					if(elseBlock != noone) elseBlock.DestroyChain();
					
					elseBlock = noone;
					
					if(elseSlot != noone) instance_destroy(elseSlot);
					
					elseSlot = noone;
					elseBodyYScale = 1;
					argElseToggle.text = "+ Else";
				}
				
				OnArgumentChanged();
			});
			
			break;
		
		case BlockType.WHILE:
			name = "While";
			SetBlockColor(BlockColor.CYAN);
			hasBody = true;
			condition = "";
			argDo = AddContent(BlockContentType.DISPLAY, BlockArgumentType.NONE, "Do");
			break;
		
		case BlockType.WAIT:
			name = "Wait";
			SetBlockColor(BlockColor.PINK);
			break;
		
		case BlockType.INTERACT:
			name = "Interact";
			SetBlockColor(BlockColor.WHITE);
			argInteraction = AddContent(BlockContentType.ARGUMENT, BlockArgumentType.CYCLE, "", [
				"Pick Up",
				"Place"
			]);
			break;
		
		case BlockType.COND_AHEAD_IS:
			name = "Ahead Is";
			SetBlockColor(BlockColor.GREEN);
			hasSequence = false;
			isConditional = true;
			argObject = AddContent(BlockContentType.ARGUMENT, BlockArgumentType.CYCLE, "", [
				"Empty",
				"Table", 
				"Chair",
				"Counter",
				"Printer",
				"Waiter"
			]);
			break;
	}
	
	if(isConditional) sprite_index = spr_ConditionalBlock;
	else sprite_index = hasBody ? spr_BlockBody : spr_Block;

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
	
	if(hasElse) {
		elseSlot = instance_create_layer(x + BLOCK_BODY_WIDTH, y, "BlockSlot", obj_BlockSlot);
		elseSlot.owner = id;
		elseSlot.type = SlotType.ELSE;
	}
	
	if(type == BlockType.IF || type == BlockType.WHILE) {
		conditionSlot = instance_create_layer(x, y, "ConditionalSlot", obj_BlockSlot);
		conditionSlot.owner = id;
		conditionSlot.type = SlotType.CONDITION;
	}
}

function LinkToSlot(slot, mute = false) {
    if(slot == noone || !slot.isEmpty) return false;
    if(isConditional && slot.type != SlotType.CONDITION) return false;
    if(!isConditional && slot.type == SlotType.CONDITION) return false;
    
    if(!mute) PlaySoundEffect(sfx_BlockConnect);
    
    parentBlock = slot.owner;
    
    if(slot.type == SlotType.BODY) slot.owner.childBlock = id;
	else if(slot.type == SlotType.ELSE) slot.owner.elseBlock = id;
    else if(slot.type == SlotType.CONDITION) slot.owner.conditionBlock = id;
    else slot.owner.nextBlock = id;
    
    slot.isEmpty = false;
    x = slot.x;
    y = slot.y;
    
    StretchParents();
	obj_EventController.FireSignal(EventSignal.BLOCKCONNECTED);
    
    return true;
}

function UnlinkFromSlot() {
	if(parentBlock == noone) return;
	
	PlaySoundEffect(sfx_BlockDisconnect);
	
	if(parentBlock.nextBlock == id) {
		parentBlock.nextBlock = noone;
		
		if(parentBlock.nextSlot != noone) parentBlock.nextSlot.isEmpty = true;
	}
	
	if(parentBlock.childBlock == id) {
		parentBlock.childBlock = noone;
		
		if(parentBlock.childSlot != noone) parentBlock.childSlot.isEmpty = true;
	}
	
	if(parentBlock.conditionBlock == id) {
		parentBlock.conditionBlock = noone;
		
		if(parentBlock.conditionSlot != noone) parentBlock.conditionSlot.isEmpty = true;
	}
	
	if(parentBlock.elseBlock == id) {
		parentBlock.elseBlock = noone;
		
		if(parentBlock.elseSlot != noone) parentBlock.elseSlot.isEmpty = true;
	}
	
	StretchParents();
	obj_EventController.FireSignal(EventSignal.BLOCKDISCONNECTED);
	
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
	Stretch();
	RefreshChain();
	StretchParents();
}

function Stretch() {
	draw_set_font(fo_UISmall);
	var offsetX = BLOCK_EDGE_LENGTH + BLOCK_PADDING + BLOCK_CONTENT_PADDING + string_width(name);
	
	if(!isConditional) offsetX += sprite_get_width(spr_BlockLightConnected);
	
	for(var i = 0; i < array_length(contents); i++) {
		var content = contents[i];
		
		if(content == argDo) continue;
		if(content == argElseToggle) continue;
		if(content.contentType != BlockContentType.DISPLAY) offsetX += BLOCK_CONTENT_PADDING;
		
		content.offsetX = offsetX;
		content.offsetY = (BLOCK_HEIGHT - BLOCK_CONTENT_HEIGHT) / 2;
		var contentWidth = content.GetValueWidth();
		
		if(content.contentType != BlockContentType.DISPLAY) content.image_xscale = contentWidth / BLOCK_CONTENT_WIDTH;
		
		offsetX += contentWidth;
	}
	
	if(type == BlockType.IF || type == BlockType.WHILE) {
	    var condWidth = conditionBlock != noone
	        ? conditionBlock.sprite_width
	        : BLOCK_CONDITION_SLOT_WIDTH;
    
	    offsetX += BLOCK_CONTENT_PADDING + condWidth;
		
		argDo.offsetX = offsetX;
		argDo.offsetY = (BLOCK_HEIGHT - BLOCK_CONTENT_HEIGHT) / 2;
		offsetX += argDo.GetValueWidth();
		
		if(argElseToggle != noone) {
			offsetX += BLOCK_CONTENT_PADDING * 2;
			argElseToggle.offsetX = offsetX;
			argElseToggle.offsetY = (BLOCK_HEIGHT - BLOCK_CONTENT_HEIGHT) / 2;
			var contentWidth = argElseToggle.GetValueWidth();
			argElseToggle.image_xscale = contentWidth / BLOCK_CONTENT_WIDTH;
			offsetX += contentWidth;
		}
	}
	
	var blockWidth = offsetX + BLOCK_CONTENT_PADDING + BLOCK_PADDING + BLOCK_EDGE_LENGTH;	
	image_xscale = blockWidth / sprite_get_width(sprite_index);
	
	if(hasBody) {
		var bodyHeight = 0;
		
		if(childBlock != noone) {
			var currentBlock = childBlock;
			
			while(currentBlock != noone) {
				bodyHeight += currentBlock.sprite_height;
				
				if(currentBlock.hasElse) bodyHeight += currentBlock.elseBodyYScale * sprite_get_height(spr_ElseBlockBody) - BLOCK_HEIGHT;
				
				currentBlock = currentBlock.nextBlock;
			}
		}
		
		image_yscale = (bodyHeight + sprite_get_height(spr_BlockBody)) / sprite_get_height(sprite_index);
	}
	
	if(hasElse) {
		var elseBodyHeight = 0;
		var currentBlock = elseBlock;
		
		while(currentBlock != noone) {
			elseBodyHeight += currentBlock.sprite_height;
			
			if(currentBlock.hasElse) elseBodyHeight += currentBlock.elseBodyYScale * sprite_get_height(spr_ElseBlockBody) - BLOCK_HEIGHT;
			
			currentBlock = currentBlock.nextBlock;
		}
		
		elseBodyYScale = (elseBodyHeight + sprite_get_height(spr_ElseBlockBody)) / sprite_get_height(spr_ElseBlockBody);
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
	
	var elseTotalHeight = hasElse ? elseBodyYScale * sprite_get_height(spr_ElseBlockBody) - BLOCK_HEIGHT : 0;
	
	if(nextSlot != noone) {
		nextSlot.x = x;
		nextSlot.y = y + sprite_height + elseTotalHeight;
	}
	
	if(childSlot != noone) {
		childSlot.x = x + BLOCK_BODY_WIDTH;
		childSlot.y = y + BLOCK_HEIGHT;
	}
	
	if(conditionSlot != noone) {
	    draw_set_font(fo_UISmall);
	    conditionSlot.x = x + BLOCK_EDGE_LENGTH + BLOCK_PADDING + sprite_get_width(spr_BlockLightConnected) + BLOCK_CONTENT_PADDING + string_width(name) + BLOCK_CONTENT_PADDING;
	    conditionSlot.y = y + (BLOCK_HEIGHT - CONDITIONAL_BLOCK_HEIGHT) / 2;
	}
	
	if(elseSlot != noone) {
		elseSlot.x = x + BLOCK_BODY_WIDTH;
		elseSlot.y = y + sprite_height;
	}
	
	if(nextBlock != noone) {
		nextBlock.x = x;
		nextBlock.y = y + sprite_height + elseTotalHeight;
		nextBlock.RefreshChain();
	}
	
	if(childBlock != noone) {
		childBlock.x = x + BLOCK_BODY_WIDTH;
		childBlock.y = y + BLOCK_HEIGHT;
		childBlock.RefreshChain();
	}
	
	if(conditionBlock != noone) {
		conditionBlock.x = conditionSlot.x;
		conditionBlock.y = conditionSlot.y;
		conditionBlock.RefreshChain();
	}
	
	if(elseBlock != noone) {
		elseBlock.x = x + BLOCK_BODY_WIDTH;
		elseBlock.y = y + sprite_height;
		elseBlock.RefreshChain();
	}
}

function DestroyChain() {
	for(var i = 0; i < array_length(contents); i++) {
		if(instance_exists(contents[i])) instance_destroy(contents[i]);
	}
	
	if(childBlock != noone) childBlock.DestroyChain();
	if(nextBlock != noone) nextBlock.DestroyChain();
	if(conditionBlock != noone && instance_exists(conditionBlock)) conditionBlock.DestroyChain();
	if(elseBlock != noone) elseBlock.DestroyChain();
	if(nextSlot != noone) instance_destroy(nextSlot);
	if(childSlot != noone) instance_destroy(childSlot);
	if(conditionSlot != noone) instance_destroy(conditionSlot);
	if(elseSlot != noone) instance_destroy(elseSlot);
	
	instance_destroy();
}

function BringToDraggingLayer() {
	layer = isConditional
		? layer_get_id("ConditionalBlockDragging")
		: layer_get_id("BlockDragging");
	
	for(var i = 0; i < array_length(contents); i++) {
		contents[i].layer = layer_get_id("BlockContentDragging");
	}
	
	if(nextSlot != noone) nextSlot.layer = layer_get_id("BlockSlotDragging");
	if(childSlot != noone) childSlot.layer = layer_get_id("BlockSlotDragging");
	if(conditionSlot != noone) conditionSlot.layer = layer_get_id("ConditionalSlotDragging");
	if(elseSlot != noone) elseSlot.layer = layer_get_id("BlockSlotDragging");
	if(nextBlock != noone) nextBlock.BringToDraggingLayer();
	if(childBlock != noone) childBlock.BringToDraggingLayer();
	if(conditionBlock != noone) conditionBlock.BringToDraggingLayer();
	if(elseBlock != noone) elseBlock.BringToDraggingLayer();
}

function BringToBaseLayer() {
	layer = isConditional
		? layer_get_id("ConditionalBlock")
		: layer_get_id("Block");
	
	for(var i = 0; i < array_length(contents); i++) {
		contents[i].layer = layer_get_id("BlockContent");
	}
	
	if(nextSlot != noone) nextSlot.layer = layer_get_id("BlockSlot");
	if(childSlot != noone) childSlot.layer = layer_get_id("BlockSlot");
	if(conditionSlot != noone) conditionSlot.layer = layer_get_id("ConditionalSlot");
	if(elseSlot != noone) elseSlot.layer = layer_get_id("BlockSlot");
	if(nextBlock != noone) nextBlock.BringToBaseLayer();
	if(childBlock != noone) childBlock.BringToBaseLayer();
	if(conditionBlock != noone) conditionBlock.BringToBaseLayer();
	if(elseBlock != noone) elseBlock.BringToBaseLayer();
}

function Serialize() {
	var node = {
		type : type,
		args : {},
		body : [],
		isDraggable : isDraggable
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
			
		case BlockType.IF:
			node.args.condition = conditionBlock != noone ? conditionBlock.Serialize() : noone;
			node.args.hasElse = hasElse;
			node.elseBody = [];
			var elseChild = elseBlock;
			
			while(elseChild != noone) {
				array_push(node.elseBody, elseChild.Serialize());
				elseChild = elseChild.nextBlock;
			}
			break;
		
		case BlockType.WHILE:
			node.args.condition = conditionBlock != noone
				? conditionBlock.Serialize()
				: noone;
			break;
		
		case BlockType.WAIT:
			break;
		
		case BlockType.INTERACT:
			node.args.interaction = argInteraction.value;
			break;
		
		case BlockType.COND_AHEAD_IS:
			node.args.objectType = argObject.value;
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
	if(type == BlockType.IF) hasElse = node.args.hasElse;
	Initialize();
	isDraggable = node.isDraggable;
	
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
			
		case BlockType.IF:
			if(node.args.condition != noone) {
				var condBlock = instance_create_layer(conditionSlot.x, conditionSlot.y, "ConditionalBlock", obj_Block);
				condBlock.Deserialize(node.args.condition);
				condBlock.LinkToSlot(conditionSlot, true);
			}
			
			if(hasElse) {
				var prevElse = noone;
				
				for(var i = 0; i < array_length(node.elseBody); i++) {
					var elseChild = instance_create_layer(elseSlot.x, elseSlot.y, "Block", obj_Block);
					elseChild.Deserialize(node.elseBody[i]);
					
					if(prevElse == noone) elseChild.LinkToSlot(elseSlot, true);
					else elseChild.LinkToSlot(prevElse.nextSlot, true);
					
					prevElse = elseChild;
				}
			}
			break;
		
		case BlockType.WHILE:
			if(node.args.condition != noone) {
				var condBlock = instance_create_layer(conditionSlot.x, conditionSlot.y, "ConditionalBlock", obj_Block);
				condBlock.Deserialize(node.args.condition);
				condBlock.LinkToSlot(conditionSlot, true);
			}
			break;
		
		case BlockType.WAIT:
			break;
		
		case BlockType.INTERACT:
			argInteraction.value = node.args.interaction;
			break;
		
		case BlockType.COND_AHEAD_IS:
			argObject.value = node.args.objectType;
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