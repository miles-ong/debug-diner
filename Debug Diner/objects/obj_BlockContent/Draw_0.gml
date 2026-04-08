if(contentType != BlockContentType.DISPLAY) draw_self();

var paddingX = BLOCK_CONTENT_PADDING;

var contentHeight = owner.isConditional
	? CONDITIONAL_BLOCK_CONTENT_HEIGHT
	: BLOCK_CONTENT_HEIGHT;

var paddingY = ((contentHeight + BLOCK_EDGE_LENGTH) - string_height("A")) / 2;
draw_set_color(global.editingBlockContent == id ? c_white : c_black);
draw_set_font(fo_UISmall);
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