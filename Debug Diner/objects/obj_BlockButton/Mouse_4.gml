if(global.isDraggingBlock == true) {
	return false;
}

global.isDraggingBlock = true;
var block = instance_create_layer(mouse_x, mouse_y, "BlockDraggingLayer", obj_Block);
block.type = type;
block.SetupType();

for(var i = 0; i < array_length(block.args); i++) {
	block.args[i].layer = layer_get_id("ArgumentsDraggingLayer");
}

block.isDragging = true;