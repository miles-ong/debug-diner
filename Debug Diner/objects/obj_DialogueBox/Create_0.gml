enum Position {
	RIGHT,
	LEFT
}

enum DialogueColor {
	BLUE,
	GREEN,
	PURPLE,
	RED,
	WHITE
}

function SetBoxColor(_color) {
	switch(_color) {
		case DialogueColor.BLUE: color = make_color_rgb(94, 196, 255); break;
		case DialogueColor.GREEN: color = make_color_rgb(97, 204, 91); break;
		case DialogueColor.PURPLE: color = make_color_rgb(192, 72, 219); break;
		case DialogueColor.RED: color = make_color_rgb(255, 69, 69); break;
		case DialogueColor.WHITE: color = c_white; break;
	}
}

boxHeight = 360;
contentPadding = 8;
textPadding = 24;
draw_set_font(fo_UIMedium);
hint = "[ Click to continue ]";
hintW = string_width(hint);
hintH = string_height(hint);
hintAlpha = -0.05;

text = "";
currentText = "";
characterSprite = noone;
position = Position.RIGHT;
color = c_white;
talkingBuffer = 0;
textFont = fo_UILarge;
charIndex = 1;
timer = 0;

function Initialize(_text, _characterSprite, _position, _color, _talkingBuffer, _font) {
	text = _text;
	characterSprite = _characterSprite;
	position = _position;
	SetBoxColor(_color);
	talkingBuffer = _talkingBuffer;
	textFont = _font;
}