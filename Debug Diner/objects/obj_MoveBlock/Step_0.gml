if (dragging) {
    x = mouse_x;
    y = mouse_y;

    var p = instance_position(x, y, obj_ProgrammingPanel);

    if(p != noone) {
        panel = p;
    } 
    else {
        panel = noone;
    }
	
	if(!mouse_check_button(mb_left)) {
		FinishDrop();
	}
}
else if(panel != noone) {
    x = panel.x + gridX * panel.cellSize;
    y = panel.y + gridY * panel.cellSize - panel.scrollY;
}