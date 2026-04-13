if(global.draggingBlock != noone) {
    global.hoveredBlockContent = noone;
    global.hoveredBlock = collision_point(mouse_x, mouse_y, obj_MainMenuBlock, true, true);
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

var hList = ds_list_create();
var hCount = collision_point_list(mouse_x, mouse_y, obj_Block, true, true, hList, true);
var hBlock = noone;
var smallestArea = infinity;

for(var i = 0; i < hCount; i++) {
    var b = hList[| i];
    var area = b.sprite_width * b.sprite_height;
	
    if(area < smallestArea) {
        smallestArea = area;
        hBlock = b;
    }
}

ds_list_destroy(hList);

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