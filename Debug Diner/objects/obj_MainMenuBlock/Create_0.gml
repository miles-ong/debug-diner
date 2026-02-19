connectedBlock = noone;
slotOffset = 0;

function Connect(block) {
	if(connectedBlock != noone) return;
	
	connectedBlock = block;
	connectedBlock.isConnected = true;
	
	switch(connectedBlock.type) {
		case MenuBlockType.NEXTLEVEL:
			// call menu function here
			break;
	}
	
	connectedBlock.x = x;
	connectedBlock.y = y + sprite_height - slotOffset;
}

function Disconnect() {
	if(connectedBlock != noone) connectedBlock.isConnected = false;
	
	connectedBlock = noone;
	
	// close side menu function here
}