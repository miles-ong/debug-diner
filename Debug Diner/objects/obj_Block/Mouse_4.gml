if(!isDraggable) {
	return;
}

global.isDraggingBlock = true;
UnlinkFromSlot();
isDragging = true;
layer = layer_get_id("DraggingLayer");