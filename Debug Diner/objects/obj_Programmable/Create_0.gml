var gridPos = obj_GridController.WorldToGrid(x, y);
gridX = gridPos.gridX;
gridY = gridPos.gridY;

targetGridX = gridX;
targetGridY = gridY;

startX = x;
startY = y;
endX = x;
endY = y;

isMoving = false;
moveProgress = 0;

program = [];
programStack = [];

canCollide = true;

clickSoundEffects = [];
hoverScale = 0.9;
scaleSpeed = 0.4;

image_speed = 0;

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
	
	var floorTile = obj_GridController.Get(GridLevel.FLOOR, targetX, targetY);
	
	if(floorTile == noone || !floorTile.isWalkable) return;
	
	var baseTile = obj_GridController.Get(GridLevel.BASE, targetX, targetY);
	
	if(baseTile != noone && baseTile.canCollide == true) return;
	
	targetGridX = targetX;
	targetGridY = targetY;
	startX = x;
	startY = y;
	var worldPos = obj_GridController.GridToWorld(targetGridX, targetGridY);
	endX = worldPos.xx;
	endY = worldPos.yy;
	moveProgress = 0;
	isMoving = true;
	
	show_debug_message("Moving Forward");
}

function Turn(dir) {
	var d = dir == TurnDirection.LEFT ? -1 : 1
	facing = (facing + d + 4) % 4;
	isMoving = true;
	
	show_debug_message("Turning");
}

function CountBlocks(nodes) {
    var count = 0;
	
    for(var i = 0; i < array_length(nodes); i++) {
        count++;
		
        if(array_length(nodes[i].body) > 0) count += CountBlocks(nodes[i].body);
    }
	
    return count;
}

function MakeFrame(nodes, index) {
	return { nodes : nodes, index : index };
}