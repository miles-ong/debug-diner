if(!isDraggable || global.isDraggingBlock) return;

if(global.hoveredBlock != id) return;

global.isDraggingBlock = true;
UnlinkFromSlot();
BringToDraggingLayer();
isDragging = true;