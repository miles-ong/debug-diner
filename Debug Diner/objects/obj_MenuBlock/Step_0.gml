if(isDragging) {
	x = mouse_x;
	y = mouse_y;
	
	if(!mouse_check_button(mb_left)) {
		global.isDraggingBlock = false;
		isDragging = false;
		layer = layer_get_id("MenuBlockLayer");
		var menuBlock = instance_position(x, y, obj_MainMenuBlock);
		
		if(menuBlock != noone) menuBlock.Connect(id);
	}
}