if(global.hoveredArgument == id || global.editingArgument == id) image_alpha = interactOpacity;
else image_alpha = opacity;

if(global.editingArgument == id) {
	switch(argumentType) {
		case BlockArgumentType.INT:
			value = keyboard_string == "" ? 0 : real(keyboard_string);
			break;
			
		case BlockArgumentType.TEXT:
			value = keyboard_string;
			break;
	}
	
	owner.Stretch();
	
	if(keyboard_check_pressed(vk_enter) || mouse_check_button(mb_left) && global.hoveredArgument != id) {
		global.editingArgument = noone;
		owner.OnArgumentChanged();
	}
}