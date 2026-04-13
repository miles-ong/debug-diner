if(global.gameState != GameState.EVENT) exit;
if(charIndex > string_length(text)) exit;

timer++;

if(timer < talkingBuffer) exit;

timer = 0;

currentText += string_char_at(text, charIndex);
charIndex++;