if(global.isDraggingBlock) {
	global.hoveredArgument = noone;
	global.hoveredBlock = noone;
	global.hoveredSlot = collision_point(mouse_x, mouse_y, obj_BlockSlot, true, true);
	
	return;
}

var hArg = collision_point(mouse_x, mouse_y, obj_BlockContent, true, true);

if(hArg != noone) {
	global.hoveredArgument = hArg;
	global.hoveredBlock = noone;
	global.hoveredSlot = noone;
	
	return;
}

var hBlock = collision_point(mouse_x, mouse_y, obj_Block, true, true);

if(hBlock != noone) {
	global.hoveredArgument = noone;
	global.hoveredBlock = hBlock;
	global.hoveredSlot = noone;
	
	return;
}

global.hoveredArgument = noone;
global.hoveredBlock = noone;
global.hoveredSlot = noone;