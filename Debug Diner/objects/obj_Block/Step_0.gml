if(isDragging) {
	x = mouse_x;
	y = mouse_y;
	
	if(!mouse_check_button(mb_left)) {
		isDragging = false;
		var slot = instance_place(x, y, obj_BlockSlot);
		
		if(!LinkToSlot(slot)) {
			var panel = instance_position(x, y, obj_ProgrammingPanel);
			
			if(panel != noone) {
				panel.SnapToGrid(id);
			}
			else {
				instance_destroy();
				return;
			}
		}
	}
}

if(nextSlot != noone) {
	nextSlot.x = x;
	nextSlot.y = y + sprite_height;
}

if(childSlot != noone) {
	childSlot.x = x + BLOCK_BODY_WIDTH;
	childSlot.y = y + BLOCK_HEIGHT;
}

if(nextBlock != noone) {
	nextBlock.x = nextSlot.x;
	nextBlock.y = nextSlot.y;
}

if(childBlock != noone && childSlot != noone) {
	childBlock.x = childSlot.x;
	childBlock.y = childSlot.y;
}