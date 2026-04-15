if(global.gameState != GameState.EVENT) exit;

if(mouse_check_button_pressed(mb_left)) {
	if(charIndex <= string_length(text)) {
		currentText = text;
		charIndex = string_length(text) + 1;
		exit;
	}
	else {
		ChangeGameState(obj_EventController.previousGameState);
		obj_EventController.FireSignal(EventSignal.DIALOGUEFINISHED);
		instance_destroy();
	}
}

if(charIndex > string_length(text)) {
	if(hintAlpha != 0.4) hintAlpha += 0.001;
	
	exit;
}

timer++;

if(timer < talkingBuffer) exit;

timer = 0;

currentText += string_char_at(text, charIndex);
charIndex++;
var pitch = random_range(0.5, 0.8);
PlaySoundEffect(sfx_TalkingBip);
audio_sound_pitch(sfx_TalkingBip, pitch);