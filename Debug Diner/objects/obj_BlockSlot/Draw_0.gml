var slot = noone;
var hoveredSlot = noone;

if(type == SlotType.CONDITION) {
	slot = spr_ConditionalBlockSlot;
	hoveredSlot = spr_ConditionalBlockSlotHovered;
}
else {
	slot = spr_BlockSlot;
	hoveredSlot = spr_BlockSlotHovered;
}

if(isEmpty && global.hoveredBlockSlot == id && global.draggingBlock != noone) {
	var drawHovered = false;
	
	if(type == SlotType.CONDITION && global.draggingBlock.isConditional) drawHovered = true;
	else if(type != SlotType.CONDITION && !global.draggingBlock.isConditional && !global.draggingBlock.isSource) drawHovered = true;
	
	if(drawHovered) {
		if(type == SlotType.CONDITION) draw_sprite_ext(hoveredSlot, 0, x, y, image_xscale, image_yscale, 0, c_white, 0.4);
		else draw_sprite(hoveredSlot, 0, x, y);
		
		return;
	}
}

if(type == SlotType.CONDITION) draw_sprite_ext(slot, 0, x, y, image_xscale, image_yscale, 0, c_white, 0.4);
else draw_sprite(slot, 0, x, y);