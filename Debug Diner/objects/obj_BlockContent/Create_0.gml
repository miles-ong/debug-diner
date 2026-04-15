event_inherited();

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
				case BlockArgumentType.CYCLE: value = 0; break;
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
	
	if(owner.isConditional) sprite_index = spr_ConditionalBlockContentArgument;
}

function OnClick() {
	switch(contentType) {
		case BlockContentType.ARGUMENT:
			PlaySoundEffect(sfx_ArgumentClick);
			
			switch(argumentType) {
				case BlockArgumentType.INT:	
					global.editingBlockContent = id;
					keyboard_string = string(value);
					break;
				
				case BlockArgumentType.BOOL:	
					value = !value;
					owner.OnArgumentChanged();
					break;
				
				case BlockArgumentType.TEXT:
					global.editingBlockContent = id;
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
				PlaySoundEffect(sfx_ArgumentClick);
				action();
			}
			
			break;
		
		case BlockContentType.DISPLAY:
			break;
	}
}

function GetValueWidth() {
	var width = 0;
	draw_set_font(fo_UISmall);
	
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
			return string_width(text) + BLOCK_CONTENT_PADDING;
	}
	
	return width + BLOCK_CONTENT_PADDING * 2;
}