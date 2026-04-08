if(!isDraggable || global.draggingBlock != noone) return;

if(global.hoveredBlock != id) return;

global.draggingBlock = id;
UnlinkFromSlot();
BringToDraggingLayer();
isDragging = true;