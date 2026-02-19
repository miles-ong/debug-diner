draw_self();
var paddingX = BLOCK_ARGUMENT_PADDING / 2;
var paddingY = (sprite_height - string_height("A")) / 2;
draw_set_color(c_black);
	
switch(type) {
	case ArgumentType.INT:
		draw_text(x + paddingX, y + paddingY, string(value));
		break;
			
	case ArgumentType.BOOL:	
		draw_text(x + paddingX, y + paddingY, value ? "True" : "False");
		break;
			
	case ArgumentType.TEXT:
		draw_text(x + paddingX, y + paddingY, value);
		break;
			
	case ArgumentType.DROPDOWN:
		draw_text(x + paddingX, y + paddingY, options[value]);
		break;
}