if(isEditing) {
	switch(type) {
		case ArgumentType.INT:
			value = keyboard_string == "" ? 0 : real(keyboard_string);
			break;
			
		case ArgumentType.TEXT:
			value = keyboard_string;
			break;
	}
	
	owner.Stretch();
	
	if(keyboard_check_pressed(vk_enter)) {
		isEditing = false;
		owner.OnArgumentChanged();
	}
}