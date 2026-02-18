gridX = round(x / TILE_SIZE);
gridY = round(y / TILE_SIZE);
x = gridX * TILE_SIZE;
y = gridY * TILE_SIZE;
targetGridX = gridX;
targetGridY = gridY;
startX = x;
startY = y;
endX = x;
endY = y;
isMoving = false;
moveProgress = 0;
program = [];
currentBlock = 0;

function MoveForward() {
	if(isMoving) {
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
	isMoving = true;
}

function Turn(dir) {
	facing = (facing + dir + 4) % 4;
}