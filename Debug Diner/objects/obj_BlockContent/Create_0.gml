owner = noone;

contentType = BlockContentType.ARGUMENT;
argumentType = BlockArgumentType.INT;

value = 0;
options = [];
text = "";
action = undefined;

offsetX = 0;
offsetY = 0;

opacity = 0.2;
interactOpacity = 0.3;

image_alpha = opacity;

function Initialize(_text = "") {
	switch(contentType) {
		case BlockContentType.ARGUMENT:
			switch(argumentType) {
				case BlockArgumentType.INT: value = 1; break;
				case BlockArgumentType.BOOL: value = true; break;
				case BlockArgumentType.TEXT: value = ""; break;
				case BlockArgumentType.CYCLE: value = 1; break;
			}
			
			sprite_index = spr_BlockContentArgument;
			break;
		
		case BlockContentType.BUTTON:
			text = _text;
			sprite_index = spr_BlockContentButton;
			break;
			
		case BlockContentType.DISPLAY:
			text = _text;
			break;
	}
}

function OnClick() {
	switch(contentType) {
		case BlockContentType.ARGUMENT:
			audio_play_sound(sfx_ArgumentClick, 0, false);
			
			switch(argumentType) {
				case BlockArgumentType.INT:	
					global.editingArgument = id;
					keyboard_string = string(value);
					break;
				
				case BlockArgumentType.BOOL:	
					value = !value;
					owner.OnArgumentChanged();
					break;
				
				case BlockArgumentType.TEXT:
					global.editingArgument = id;
					keyboard_string = value;
					break;
				
				case BlockArgumentType.CYCLE:	
					value = (value + 1) % array_length(options);
					owner.OnArgumentChanged();
					break;
			}
			
			break;
			
		case BlockContentType.BUTTON:
			if(action != undefined) {
				audio_play_sound(sfx_ArgumentClick, 0, false);
				action();
			}
			
			break;
		
		case BlockContentType.DISPLAY:
			break;
	}
}

function GetValueWidth() {
	var width = 0;
	draw_set_font(fo_basic);
	
	switch(contentType) {
		case BlockContentType.ARGUMENT:
			switch(argumentType) {
				case BlockArgumentType.INT: width = string_width(string(value)); break;
				case BlockArgumentType.BOOL: width = string_width(value ? "True" : "False"); break;
				case BlockArgumentType.TEXT: width = string_width(value); break;
				case BlockArgumentType.CYCLE: width = string_width(options[value]); break;
			}
			break;
		
		case BlockContentType.BUTTON:
			width = string_width(text);
			break;
		
		case BlockContentType.DISPLAY:
			width = string_width(text);
			break;
	}
	
	return width + BLOCK_CONTENT_PADDING * 2;
}