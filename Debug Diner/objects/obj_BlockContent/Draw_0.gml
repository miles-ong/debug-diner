if(contentType != BlockContentType.DISPLAY) draw_self();

var paddingX = BLOCK_CONTENT_PADDING;
var paddingY = ((BLOCK_CONTENT_HEIGHT + BLOCK_EDGE_LENGTH) - string_height("A")) / 2;
draw_set_color(global.editingArgument == id ? c_white : c_black);
draw_set_font(fo_basic);
var displayText = "";

switch(contentType) {
	case BlockContentType.ARGUMENT:
		switch(argumentType) {
			case BlockArgumentType.INT: displayText = string(value); break;
			case BlockArgumentType.BOOL: displayText = value ? "True" : "False"; break;
			case BlockArgumentType.TEXT: displayText = value; break;
			case BlockArgumentType.CYCLE: displayText = options[value]; break;
		}
		break;
	
	case BlockContentType.BUTTON:	
		displayText = text;
		break;
	
	case BlockContentType.DISPLAY:
		displayText = text;
		break;
}

draw_text(x + paddingX, y + paddingY, displayText);