grid = {};
plannedMoves = {};

function Fill() {
	grid = {};
	
	with(obj_Floor) {
		var gCoords = other.WorldToGrid(x, y);
		other.Set(GridLevel.FLOOR, gCoords.gridX, gCoords.gridY, id);
		show_debug_message("Added Floor at " + string(gCoords.gridX) + ", " + string(gCoords.gridY));
	}
	
	with(obj_Base) {
		var gCoords = other.WorldToGrid(x, y);
		other.Set(GridLevel.BASE, gCoords.gridX, gCoords.gridY, id);
		show_debug_message("Added Base at " + string(gCoords.gridX) + ", " + string(gCoords.gridY));
	}
	
	with(obj_Programmable) {
		var gCoords = other.WorldToGrid(x, y);
		var level = layer_get_name(layer) == "Base" ? GridLevel.BASE : GridLevel.FLOOR;
		other.Set(level, gCoords.gridX, gCoords.gridY, id);
		show_debug_message("Added Programmable at " + string(gCoords.gridX) + ", " + string(gCoords.gridY));
	}
}

function Get(level, gridX, gridY) {
	if(Exists(level, gridX, gridY)) return grid[$ Key(level, gridX, gridY)];
	
	return noone;
}

function GetInDirection(level, gridX, gridY, dir, dist = 1) {
	switch(dir) {
		case Direction.NORTH: gridY -= dist; break;
		case Direction.EAST: gridX += dist; break;
		case Direction.SOUTH: gridY += dist; break;
		case Direction.WEST: gridX -= dist; break;
	}
	
	return Get(level, gridX, gridY);
}

function GetInProximity(level, gridX, gridY) {
	var proximity = [];
	
	for(var dir = Direction.NORTH; dir <= Direction.WEST; dir++) {
		array_push(proximity, GetInDirection(level, gridX, gridY, dir)); 
	}
	
	return proximity;
}

function Set(level, gridX, gridY, inst) {
	grid[$ Key(level, gridX, gridY)] = inst;
}

function Remove(level, gridX, gridY) {
	variable_struct_remove(grid, Key(level, gridX, gridY));
}

function Exists(level, gridX, gridY) {
	return variable_struct_exists(grid, Key(level, gridX, gridY));
}

function Key(level, gridX, gridY) {
	return string(level) + "_" + string(gridX) + "_" + string(gridY);
}

function ParseKey(key) {
	var parts = string_split(key, "_");
	
	return {
		level : real(parts[0]),
		xx : real(parts[1]),
		yy : real(parts[2])
	};
}

function WorldToGrid(xx, yy) {	
	return {
		gridX : floor((xx - BOARD_PADDING) / BOARD_TILE_SIZE),
		gridY : floor((yy - BOARD_PADDING) / BOARD_TILE_SIZE)
	};
}

function GridToWorld(gridX, gridY) {
	return {
		xx : (gridX * BOARD_TILE_SIZE) + BOARD_PADDING + BOARD_TILE_SIZE / 2,
		yy : (gridY * BOARD_TILE_SIZE) + BOARD_PADDING + BOARD_TILE_SIZE / 2
	};
}

function ClearPlans() {
	plannedMoves = {};
}

function PlanMove(_inst, _startX, _startY, _targetX, _targetY) {
	var key = Key(GridLevel.BASE, _targetX, _targetY);
	
	if(!variable_struct_exists(plannedMoves, key)) plannedMoves[$ key] = [];
	
	array_push(plannedMoves[$ key], {
		inst : _inst,
		startX : _startX,
		startY : _startY,
		targetX : _targetX,
		targetY : _targetY
	});
}

function ResolvePlans() {
	var keys = variable_struct_get_names(plannedMoves);
	
	for(var i = 0; i < array_length(keys); i++) {
		var key = keys[i];
		var parsed = ParseKey(key);
		var moves = plannedMoves[$ key];
		
		if(array_length(moves) > 1) {
			for(var j = 0; j < array_length(moves); j++) {
				var m = moves[j];
				m.inst.targetGridX = parsed.xx;
				m.inst.targetGridY = parsed.yy;
				m.inst.OnCollision(GetMoveDirection(m.startX, m.startY, parsed.xx, parsed.yy));
			}
			continue;
		}
		
		var move = moves[0];
		var inst = move.inst;
		var occupant = Get(parsed.level, parsed.xx, parsed.yy);
		
		if(occupant != noone) {
			inst.targetGridX = parsed.xx;
			inst.targetGridY = parsed.yy;
			var dir = GetMoveDirection(move.startX, move.startY, parsed.xx, parsed.yy);
			inst.OnCollision(dir);
			occupant.OnCollision(GetOppositeDirection(dir));
			continue;
		}
		
		ExecuteMove(inst, parsed.xx, parsed.yy);
	}
	
	ClearPlans();
}

function ExecuteMove(inst, targetX, targetY) {
	Remove(GridLevel.BASE, inst.gridX, inst.gridY);
	
	inst.targetGridX = targetX;
	inst.targetGridY = targetY;
	
	var worldPos = GridToWorld(targetX, targetY);
	inst.startX = inst.x;
	inst.startY = inst.y;
	inst.endX = worldPos.xx;
	inst.endY = worldPos.yy;
	inst.moveProgress = 0;
	inst.isMoving = true;
	
	Set(GridLevel.BASE, targetX, targetY, inst);
}

function GetMoveDirection(_startX, _startY, _targetX, _targetY) {
	if(_startX > _targetX) return Direction.WEST;
	if(_startX < _targetX) return Direction.EAST;
	if(_startY > _targetY) return Direction.NORTH;
	if(_startY < _targetY) return Direction.SOUTH;
	
	return undefined;
}

function GetOppositeDirection(_direction) {
	switch(_direction) {
		case Direction.NORTH: return Direction.SOUTH;
		case Direction.SOUTH: return Direction.NORTH;
		case Direction.EAST: return Direction.WEST;
		case Direction.WEST: return Direction.EAST;
	}
}

function ObjectFacingObject(o1, o2) {
	if(!variable_instance_exists(o1, "facing")) return false;
	
	var dirToO2;
	
	if(o1.gridX < o2.gridX) dirToO2 = Direction.EAST;
	else if(o1.gridX > o2.gridX) dirToO2 = Direction.WEST;
	else if(o1.gridY < o2.gridY) dirToO2 = Direction.SOUTH;
	else if(o1.gridY > o2.gridY) dirToO2 = Direction.NORTH;
	
	return o1.facing == dirToO2;
}