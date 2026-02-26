connectedBlock = noone;
slotOffset = 50;

function Connect(block) {
	if(connectedBlock != noone) return false;
	
	audio_play_sound(sfx_BlockConnect, 0, false);
	connectedBlock = block;
	connectedBlock.isConnected = true;
	
	switch(connectedBlock.type) {
		case MenuBlockType.LEVELSELECT:
			// call level select function here
			break;
			
		case MenuBlockType.CONTINUE:
			obj_GameController.GoToLevel(0);
			
			break;
			
		case MenuBlockType.SETTINGS:
			// call settings function here
			break;
	}
	
	connectedBlock.x = x;
	connectedBlock.y = y + sprite_height - slotOffset;
	
	return true;
}

function Disconnect() {
	if(connectedBlock != noone) connectedBlock.isConnected = false;
	
	audio_play_sound(sfx_BlockDisconnect, 0, false);
	connectedBlock = noone;
	
	// close side menu function here
}