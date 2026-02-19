if(!isDraggable || global.isDraggingBlock) return;

global.isDraggingBlock = true;
UnlinkFromSlot();
BringToDraggingLayer();
isDragging = true;