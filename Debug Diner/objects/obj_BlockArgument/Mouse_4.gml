if(global.isDraggingBlock) return;

switch(type) {
	case ArgumentType.INT:
		isEditing = true;
		keyboard_string = string(value);
		break;
	
	case ArgumentType.BOOL:
		value = !value;
		owner.OnArgumentChanged();
		break;
	
	case ArgumentType.TEXT:
		isEditing = true;
		keyboard_string = value;
		break;
		
	case ArgumentType.DROPDOWN:
		value = (value + 1) % array_length(options);
		owner.OnArgumentChanged();
		break;
}