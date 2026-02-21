owner = noone;
type = ArgumentType.INT;
value = 0;
options = [];
isEditing = false;
offsetX = 0;
offsetY = 0;

opacity = 0.2;
hoverOpacity = 0.3;

image_alpha = opacity;

function SetupType() {
	switch(type) {
		case ArgumentType.INT:
			value = 1;
			break;
		
		case ArgumentType.BOOL:
			value = true;
			break;
			
		case ArgumentType.TEXT:
			value = "";
			break;
		
		case ArgumentType.DROPDOWN:
			value = 0;
			break;
	}
}

function OnClick() {
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
}

function GetValueWidth() {
	var width = 0;
	draw_set_font(fo_basic);
	
	switch(type) {
		case ArgumentType.INT: width = string_width(string(value)); break;
		case ArgumentType.BOOL: width = string_width(value ? "True" : "False"); break;
		case ArgumentType.TEXT: width = string_width(value); break;
		case ArgumentType.DROPDOWN: width = string_width(options[value]); break;
	}
	
	return width + BLOCK_ARGUMENT_PADDING * 2;
}