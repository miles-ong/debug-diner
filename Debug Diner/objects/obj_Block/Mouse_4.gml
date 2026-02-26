if(!isDraggable || global.isDraggingBlock) return;

for(var i = 0; i < array_length(contents); i++) {
	var content = contents[i];
	
	if(point_in_rectangle(mouse_x, mouse_y, content.x, content.y, content.x + content.GetValueWidth(), content.y + BLOCK_CONTENT_HEIGHT)) {
		content.OnClick();
		return;
	}
}

global.isDraggingBlock = true;
UnlinkFromSlot();
BringToDraggingLayer();
isDragging = true;