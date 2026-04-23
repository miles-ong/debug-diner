if(global.gameState != GameState.PROGRAMMING) exit;

if(global.draggingBlock != noone) {
	return false;
}

var layerId = isConditional 
	? "ConditionalBlockDragging"
	: "BlockDragging";
	
var block = instance_create_layer(mouse_x, mouse_y, layerId, obj_Block);
block.type = type;
block.Initialize();

if(block.type == BlockType.DEFINE && instance_exists(obj_Terminal)) obj_Terminal.AddFunction(block.argDef.value);

block.BringToDraggingLayer();
global.draggingBlock = block;
block.isDragging = true;