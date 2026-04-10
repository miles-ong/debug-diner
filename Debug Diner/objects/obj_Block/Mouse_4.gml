if(!isDraggable || global.draggingBlock != noone || global.gameState != GameState.PROGRAMMING) return;

if(global.hoveredBlock != id) return;

global.draggingBlock = id;
UnlinkFromSlot();
BringToDraggingLayer();
isDragging = true;