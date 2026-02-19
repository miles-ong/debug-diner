if(!isDraggable || global.isDraggingBlock) return;

for(var i = 0; i < array_length(args); i++) {
	var arg = args[i];
	
	if(point_in_rectangle(mouse_x, mouse_y, arg.x, arg.y, arg.x + arg.GetValueWidth(), arg.y + arg.sprite_height)) {
		arg.OnClick();
		return;
	}
}

global.isDraggingBlock = true;
UnlinkFromSlot();
BringToDraggingLayer();
isDragging = true;