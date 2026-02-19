if(isEditing) {
	switch(type) {
		case ArgumentType.INT:
			value = real(keyboard_string);
			break;
			
		case ArgumentType.TEXT:
			value = keyboard_string;
			break;
	}
	
	if(keyboard_check_presed(vk_enter)) {
		isEditing = false;
		owner.OnArgumentChanged();
	}
}