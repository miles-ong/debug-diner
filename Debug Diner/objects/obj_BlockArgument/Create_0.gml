owner = noone;
type = ArgumentType.INT;
value = 0;
options = [];
isEditing = false;
offsetX = 0;
offsetY = 0;

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

function GetValueWidth() {
	switch(type) {
		case ArgumentType.INT: return string_width(string(value)) + BLOCK_ARGUMENT_PADDING;
		case ArgumentType.BOOL: return 16; // unfinished
		case ArgumentType.TEXT: return string_width(value);
		case ArgumentType.DROPDOWN: return string_width(options[value]) + BLOCK_ARGUMENT_PADDING;
	}
}