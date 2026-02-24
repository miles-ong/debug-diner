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
programStack = [];

canCollide = true;

function MoveForward() {
	if(isMoving) return;
	
	var targetX = gridX;
	var targetY = gridY;
	
	switch(facing) {
		case Direction.NORTH: targetY = gridY - 1; break;
		case Direction.EAST: targetX = gridX + 1; break;
		case Direction.SOUTH: targetY = gridY + 1; break;
		case Direction.WEST: targetX = gridX - 1; break;
	}
	
	var cell = obj_GridController.Get(GridLevel.FLOOR, targetX, targetY);
	
	if(cell == noone || !cell.walkable) return;
	
	targetGridX = targetX;
	targetGridY = targetY;
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
	isMoving = true;
}

function MakeFrame(nodes, index) {
	return { nodes : nodes, index : index };
}