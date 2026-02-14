function move_forward() {
	if(moving) {
		return;
	}
	
	switch(facing) {
		case Direction.NORTH: targetGridY = gridY - 1; break;
		case Direction.EAST: targetGridX = gridX + 1; break;
		case Direction.SOUTH: targetGridY = gridY + 1; break;
		case Direction.WEST: targetGridX = gridX - 1; break;
	}
	
	startX = x;
	startY = y;
	endX = targetGridX * TILE_SIZE;
	endY = targetGridY * TILE_SIZE;
	
	moveProgress = 0;
	moving = true;
}

function turn(dir) {
	facing = (facing + dir + 4) % 4;
}