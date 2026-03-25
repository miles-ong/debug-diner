// --- Setup ---
label = "";
debugLabel = "[obj_Entity]";

// --- Settings ---
gridLevel = undefined;
collision = false;
animateCollision = false;
collisionKnockback = 0;
collisionRotation = 0;

// --- Grid Position ---
gridX = obj_GridController.WorldToGrid(x, y).gx;
gridY = obj_GridController.WorldToGrid(x, y).gy;
targetGridX = gridX;
targetGridY = gridY;

// --- Move Animation ---
moving = false;
moveProgress = 0;
startX = x;
startY = y;
endX = x;
endY = y;
collisionStartX = x;
collisionStartY = y;
knockbackX = 0;
knockbackY = 0;

// --- Collision Animation ---
colliding = false;
collisionPhase = 0;
collisionProgress = 0;
collisionCurveSpeed = animcurve_get_channel(cu_CrashFallback, "_speed");

/// @description Helper to initialize basic entity settings
/// @param _gridLevel Level on the grid to exist
/// @param _collision Enables collision
/// @param _animateCollision Enables collision animation
/// @param _collisionKnockback Pixels to be knocked back on collision
/// @param _collisionRotation Angle to rotate on collision
function SetupEntity(
	_gridLevel,
	_collision,
	_animateCollision = false,
	_collisionKnockback = 0,
	_collisionRotation = 0
) {
	gridLevel = _gridLevel;
	collision = _collision;
	animateCollision = _animateCollision;
	collisionKnockback = _collisionKnockback;
	collisionRotation = _collisionRotation;
}

function PlanMove(_direction = undefined, _distance = 1) {
	if(global.gameState != GameState.READING) {
		show_debug_message($"{debugLabel} '{label}' cannot plan move while the game state is not set to READING");
		return;
	}
	
	var dir = _direction != undefined ? _direction : facing;
	
	if(dir == undefined) {
		show_debug_message($"{debugLabel} '{label}' cannot plan move if both _direction and facing are undefined");
		return;
	}
	
	var dirCoords = GetGridCoordinatesInDirection(gridX, gridY, dir, _distance);
	targetGridX = dirCoords.gx;
	targetGridY = dirCoords.gy;
	var floorTile = obj_GridController.Get(targetGridX, targetGridY, GridLevel.FLOOR);
	
	if(floorTile != noone) {
		if(!floorTile.isWalkable) {
			show_debug_message($"{debugLabel} '{label}' cannot move to ({targetGridX}, {targetGridY}) because the floor tile is not walkable");
			targetGridX = gridX;
			targetGridY = gridY;
			return;
		}
	}
	else {
		show_debug_message($"{debugLabel} '{label}' cannot move to ({targetGridX}, {targetGridY}) because no floor tile exists");
		targetGridX = gridX;
		targetGridY = gridY;
		return;
	}
	
	startX = x;
	startY = y;
	var worldCoords = obj_GridController.GridToWorld(targetGridX, targetGridY);
	endX = worldCoords.xx;
	endY = worldCoords.yy;
	show_debug_message($"{debugLabel} '{label}' planning move from ({gridX}, {gridY}) to ({targetGridX}, {targetGridY})");
	obj_StepController.LoadStep(id);
	moving = true;
}

function Turn(_turnDirection) {
	if(facing == undefined) {
		show_debug_message($"{debugLabel} '{label}' cannot turn if facing is undefined");
		return;
	}
	
	var dir = _turnDirection == TurnDirection.LEFT ? -1 : 1;
	facing = (facing + dir + 4) % 4;
	show_debug_message($"{debugLabel} '{label}' turned to the {TurnDirectionToString(_turnDirection)}");
}

function HandleCollision(_moveDirection) {
	if(!collision) return;
	
	colliding = true;
	collisionPhase = 0;
	collisionProgress = 0;
	
	var worldPos = obj_GridController.GridToWorld(targetGridX, targetGridY);
	startX = x;
	startY = y;
	endX = worldPos.xx;
	endY = worldPos.yy;
	
	switch(_moveDirection) {
		case Direction.NORTH:
			collisionRotation = -45;
			knockbackY = collisionKnockback;
			break;
		
		case Direction.EAST:
			collisionRotation = 90;
			knockbackX = -collisionKnockback;
			break;
		
		case Direction.SOUTH:
			collisionRotation = 45;
			knockbackY = -collisionKnockback;
			break;
		
		case Direction.WEST:
			collisionRotation = -90;
			knockbackX = collisionKnockback;
			break;
	}
}