function FinishDrop() {
	dragging = false;
	
	if(panel != noone) {
		gridX = floor((mouse_x - panel.x) / panel.cellSize);
		gridY = floor((mouse_y - panel.y - panel.scrollY) / panel.cellSize);
		
		if(ds_list_find_index(panel.blocks, id) == -1) {
			ds_list_add(panel.blocks, id);
		}
		
		SaveSelectedProgram();
	}
	else {
		instance_destroy();
	}
}