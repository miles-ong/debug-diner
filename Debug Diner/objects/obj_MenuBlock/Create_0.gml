type = MenuBlockType.NEXTLEVEL;
isDragging = false;
isConnected = false;

function SetupType() {
	switch(type) {
		case MenuBlockType.NEXTLEVEL:
			sprite_index = spr_NextLevelBlock;
			break;
	}
}