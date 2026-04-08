if(global.gameState != GameState.PROGRAMMING) exit;

if(global.isDraggingBlock == true) {
	return false;
}

global.isDraggingBlock = true;

var layerId = isConditional 
	? "ConditionalBlockDragging"
	: "BlockDragging";
	
var block = instance_create_layer(mouse_x, mouse_y, layerId, obj_Block);
block.type = type;
block.Initialize();
block.BringToDraggingLayer();
block.isDragging = true;