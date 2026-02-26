if(global.isDraggingBlock == true) {
	return false;
}

global.isDraggingBlock = true;

var block = instance_create_layer(mouse_x, mouse_y, "BlockDragging", obj_Block);
block.type = type;
block.Initialize();
block.BringToDraggingLayer();
block.isDragging = true;