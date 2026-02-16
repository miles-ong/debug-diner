if(global.selectedProgram == noone) {
	visible = false;
	return;
}

visible = true;

if(currentOwner != global.selectedProgram) {
	currentOwner = global.selectedProgram;
	LoadSelectedProgram();
}

var wheel = mouse_wheel_up() - mouse_wheel_down();
scrollY -= wheel * scrollSpeed;
var maxRow = 0;

for(var i = 0; i < ds_list_size(blocks); i++) {
	var block = blocks[| i];
	
	if(!instance_exists(block)) {
		ds_list_delete(blocks, i);
		continue;
	}
	
	maxRow = max(maxRow, block.gridY);
}

var contentHeight = (maxRow + 1) * cellSize;
var viewHeight = bbox_bottom - bbox_top;
scrollY = clamp(scrollY, 0, max(0, contentHeight - viewHeight));