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
isCrashing = false;
crashProgress = 0;
crashPhase = 0;
crashDuration = 40;
crashRotation = 0;
crashBlend = 0;

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
	
	with(obj_Programmable) {
		if(id == other.id || !canCollide || !other.canCollide) continue;
		
		var sameTarget = (targetX == targetGridX && targetY == targetGridY);
		var headOn = (targetX == gridX && targetY == gridY && targetGridX == other.gridX && targetGridY == other.gridY);
		
		if(sameTarget || headOn) {
			var worldPos = obj_GridController.GridToWorld(targetX, targetY);
			Crash(worldPos.xx, worldPos.yy);
			
			if(headOn) {
				var otherWorldPos = obj_GridController.GridToWorld(other.targetGridX, other.targetGridY);
				Crash(otherWorldPos.xx, otherWorldPos.yy);
			}
			else {
				var awayX = other.gridX;
				var awayY = other.gridY;
				
				switch(facing) {
					case Direction.NORTH: awayY += 1; break;
					case Direction.EAST: awayX -= 1; break;
					case Direction.SOUTH: awayY -= 1; break;
					case Direction.WEST: awayX += 1; break;
				}
				
				var otherWorldPos = obj_GridController.GridToWorld(awayX, awayY);
				other.Crash(otherWorldPos.xx, otherWorldPos.yy);
			}
		}
	}
	
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

function Crash(targetWorldX, targetWorldY) {
	isCrashing = true;
	crashProgress = 0;
	startX = x;
	startY = y;
	endX = targetWorldX
	endY = targetWorldY
	
	var backDir = (facing + 2) % 4;
	
	switch(backDir) {
		case Direction.NORTH: crashRotation = 45; break;
		case Direction.EAST: crashRotation = -90; break;
		case Direction.SOUTH: crashRotation = -45; break;
		case Direction.WEST: crashRotation = 90; break;
	}
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