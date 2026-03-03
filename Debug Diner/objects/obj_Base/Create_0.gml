var gridPos = obj_GridController.WorldToGrid(x, y);
gridX = gridPos.gridX;
gridY = gridPos.gridY;
targetGridX = gridX;
targetGridY = gridY;

canCollide = true;
animateCollision = false;
collisionKnockback = 0;
collisionRotation = 0;
isColliding = false;
collisionProgress = 0;
collisionPhase = 0;
collisionCurveSpeed = animcurve_get_channel(cu_CrashFallback, "spd");

isMoving = false;
moveProgress = 0;
startX = x;
startY = y;
collisionStartX = x;
collisionStartY = y;
endX = x;
endY = y;
knockbackX = 0;
knockbackY = 0;

layer = layer_get_id("Base");

function SetupCollision(_canCollide, _animateCollision = false, _collisionKnockback = 25) {
	canCollide = _canCollide;
	animateCollision = _animateCollision;
	collisionKnockback = _collisionKnockback;
}

function PlanMove(_direction = undefined) {
	if(isMoving) return;
	
	var dir = _direction != undefined ? _direction : facing;
	
	if(dir == undefined) {
		show_debug_message("Cannot move if both _direction and facing are undefined");
		return;
	}
	
	var targetX = gridX;
	var targetY = gridY;
		
	switch(dir) {
		case Direction.NORTH: targetY -= 1; break;
		case Direction.EAST: targetX += 1; break;
		case Direction.SOUTH: targetY += 1; break;
		case Direction.WEST: targetX -= 1; break;
	}
	
	var floorTile = obj_GridController.Get(GridLevel.FLOOR, targetX, targetY);
	
	if(floorTile == noone || !floorTile.isWalkable) return;
	
	obj_GridController.PlanMove(id, gridX, gridY, targetX, targetY);
}

function Turn(_direction) {
	if(facing == undefined) return;
	
	var dir = _direction == TurnDirection.LEFT ? -1 : 1
	facing = (facing + dir + 4) % 4;
	isMoving = true;
}

function OnCollision(_impactDirection) {
	if(!canCollide) return;
	
	isMoving = true;
	isColliding = true;
	moveProgress = 0;
	collisionPhase = 0;
	collisionProgress = 0;
	
	var worldPos = obj_GridController.GridToWorld(targetGridX, targetGridY);
	startX = x;
	startY = y;
	endX = worldPos.xx;
	endY = worldPos.yy;
	
	switch(_impactDirection) {
		case Direction.NORTH: 
			collisionRotation = -45;
			knockbackY = collisionKnockback; 
			break;
		case Direction.EAST: 
			collisionRotation = 90
			knockbackX = -collisionKnockback; 
			break;
		case Direction.SOUTH: 
			collisionRotation = 45
			knockbackY = -collisionKnockback; 
			break;
		case Direction.WEST: 
			collisionRotation = -90;
			knockbackX = collisionKnockback; 
			break;
	}
}