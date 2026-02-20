if(global.isDraggingBlock) return;

global.isDraggingBlock = true;

if(isConnected) obj_MainMenuBlock.Disconnect();

layer = layer_get_id("MenuBlockDraggingLayer");
isDragging = true;

show_debug_message("press finished");