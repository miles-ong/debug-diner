if(global.hoveredBlockContent == id || global.editingBlockContent == id) image_alpha = interactOpacity;
else image_alpha = opacity;

if(global.editingBlockContent == id) {
	switch(argumentType) {
		case BlockArgumentType.INT:
		    keyboard_string = string_digits(keyboard_string);
		    value = keyboard_string == "" ? 0 : real(keyboard_string);
		    break;
			
		case BlockArgumentType.TEXT:
			value = keyboard_string;
			break;
	}
	
	owner.Stretch();
	
	if(keyboard_check_pressed(vk_enter) || mouse_check_button(mb_left) && global.hoveredBlockContent != id) {
		if(owner.type == BlockType.DEFINE) {
			value = obj_Terminal.GetUniqueFunctionDefinition(value);
			obj_Terminal.ModifyFunctionDefinition(prevValue, value);
		}
		
		global.editingBlockContent = noone;
		owner.OnArgumentChanged();
	}
}