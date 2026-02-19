if(global.isDraggingBlock) return;

global.isDraggingBlock = true;
obj_MainMenuBlock.Disconnect();
layer = layer_get_id("BlockDraggingLayer");
isDragging = true;