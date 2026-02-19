if(isDragging) {
	x = mouse_x;
	y = mouse_y;
	RefreshChain();
	
	if(!mouse_check_button(mb_left)) {
		global.isDraggingBlock = false;
		isDragging = false;
		layer = layer_get_id("GameInterface");
		var slot = instance_position(x, y, obj_BlockSlot);
		
		if(!LinkToSlot(slot)) {
			var panel = instance_position(x, y, obj_ProgrammingPanel);
			
			if(panel != noone) {
				panel.SnapToGrid(id);
				RefreshChain();
			}
			else {
				DestroyChain();
				return;
			}
		}
		else {
			RefreshChain();
		}
		
		return;
	}
}