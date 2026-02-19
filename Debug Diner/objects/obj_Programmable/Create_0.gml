gridX = round(x / CELL_SIZE);
gridY = round(y / CELL_SIZE);
x = gridX * CELL_SIZE;
y = gridY * CELL_SIZE;
targetGridX = gridX;
targetGridY = gridY;
startX = x;
startY = y;
endX = x;
endY = y;
isMoving = false;
moveProgress = 0;
remainingTiles = 0;
program = [];
currentBlock = 0;

canCollide = true;

function MoveForward() {
	if(isMoving) return;
	
	switch(facing) {
		case Direction.NORTH: targetGridY = gridY - 1; break;
		case Direction.EAST: targetGridX = gridX + 1; break;
		case Direction.SOUTH: targetGridY = gridY + 1; break;
		case Direction.WEST: targetGridX = gridX - 1; break;
	}
	
	startX = x;
	startY = y;
	endX = targetGridX * CELL_SIZE;
	endY = targetGridY * CELL_SIZE;
	moveProgress = 0;
	isMoving = true;
}

function Turn(dir) {
	var d = dir == TurnDirection.LEFT ? -1 : 1
	facing = (facing + d + 4) % 4;
}