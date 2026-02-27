if(global.isDraggingBlock) {
	global.hoveredBlockContent = noone;
	global.hoveredBlock = noone;
	global.hoveredBlockSlot = collision_point(mouse_x, mouse_y, obj_BlockSlot, true, true);
	global.hoveredProgrammable = noone;
	
	return;
}

var hContent = collision_point(mouse_x, mouse_y, obj_BlockContent, true, true);

if(hContent != noone) {
	global.hoveredBlockContent = hContent;
	global.hoveredBlock = noone;
	global.hoveredBlockSlot = noone;
	global.hoveredProgrammable = noone;
	
	return;
}

var hBlock = collision_point(mouse_x, mouse_y, obj_Block, true, true);

if(hBlock != noone) {
	global.hoveredBlockContent = noone;
	global.hoveredBlock = hBlock;
	global.hoveredBlockSlot = noone;
	global.hoveredProgrammable = noone;
	
	return;
}

var hProgrammable = collision_point(mouse_x, mouse_y, obj_Programmable, true, true);

if(hProgrammable != noone) {
	global.hoveredBlockContent = noone;
	global.hoveredBlock = noone
	global.hoveredBlockSlot = noone;
	global.hoveredProgrammable = hProgrammable;
	
	return;
}

if(global.hoveredProgrammable != noone) {
	var previous = global.hoveredProgrammable;
	var distance = point_distance(mouse_x, mouse_y, previous.x, previous.y);
	
	if(distance < previous.sprite_width * hoverClearRadius) return;
}

global.hoveredBlockContent = noone;
global.hoveredBlock = noone;
global.hoveredBlockSlot = noone;
global.hoveredProgrammable = noone;