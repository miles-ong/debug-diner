if(!isDraggable || global.isDraggingBlock) return;

global.isDraggingBlock = true;
UnlinkFromSlot();
layer = layer_get_id("BlockDraggingLayer");

for(var i = 0; i < array_length(args); i++) {
	args[i].layer = layer_get_id("ArgumentsDraggingLayer");
}

isDragging = true;