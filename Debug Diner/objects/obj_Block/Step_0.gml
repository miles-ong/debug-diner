if(isDragging) {
	x = mouse_x;
	y = mouse_y;
	RefreshChain();
	
	var slotHover = instance_position(x, y, obj_BlockSlot);
	
	if(slotHover != hoveredSlot) {
	    if(hoveredSlot != noone) {
	        hoveredSlot.image_index = SlotSprite.CANNOTCONNECT; // reset old slot
	    }
		
	    hoveredSlot = slotHover;
		
	    if(hoveredSlot != noone) {
	        if(hoveredSlot.isEmpty) {
	            hoveredSlot.image_index = SlotSprite.CANCONNECT;
	        } 
			else {
	            hoveredSlot.image_index = SlotSprite.CANNOTCONNECT;
	        }
	    }
	}
	
	if(!mouse_check_button(mb_left)) {
		global.isDraggingBlock = false;
		isDragging = false;
		BringToBaseLayer();
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
		
		if(instance_position(mouse_x, mouse_y, id) == id) EnterHover(hoverStrength);
		else ExitHover();
	}
}