if(isEmpty && global.hoveredBlockSlot == id) {
	draw_sprite(spr_BlockSlotHovered, 0, x, y);
	
	return;
}

draw_sprite(spr_BlockSlot, 0, x, y);