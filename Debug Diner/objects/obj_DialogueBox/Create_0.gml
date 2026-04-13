enum DialoguePosition {
	RIGHT,
	LEFT
}

text = "";
currentText = "";
textFont = fo_UIMedium;
characterSprite = noone;
position = DialoguePosition.RIGHT;
talkingBuffer = 0;
charIndex = 0;
timer = 0;

function Initialize(_text, _font, _characterSprite, _position, _talkingBuffer = 4) {
	text = _text;
	textFont = _font;
	characterSprite = _characterSprite;
	position = _position;
	talkingBuffer = _talkingBuffer;
}