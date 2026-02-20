connectedBlock = noone;
slotOffset = 50;

function Connect(block) {
	if(connectedBlock != noone) return false;
	
	connectedBlock = block;
	connectedBlock.isConnected = true;
	
	switch(connectedBlock.type) {
		case MenuBlockType.NEXTLEVEL:
			// call menu function here
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
	
	connectedBlock = noone;
	
	// close side menu function here
}