// --- Setup ---
debugLabel = "[obj_GridController]";

// --- Grids ---
floorGrid = {};
baseGrid = {};

/// @description Clears floor and base grids and fills them with all entities present in the room
function Initialize() {
	floorGrid = {};
	baseGrid = {};
	
	with(obj_Entity) {
		var gCoords = other.WorldToGrid(x, y);
		other.Set(gCoords.gx, gCoords.gy, id);
	}
	
	show_debug_message($"{debugLabel} Initialized");
}

/// @description Sets an entity to a grid coordinate
/// @param _gx X coordinate in grid
/// @param _gy Y coordinate in grid
/// @param _entity The entity to be set
function Set(_gx, _gy, _entity) {
	var grid = _entity.gridLevel == GridLevel.FLOOR ? floorGrid : baseGrid;
	grid[$ Key(_gx, _gy)] = _entity;
	show_debug_message($"{debugLabel} Set {GridLevelToString(_entity.gridLevel)} '{_entity.label}' at ({_gx}, {_gy})");
}

/// @description Gets an entity from given grid coordinates. Returns noone if no entity is found
/// @param _gx X coordinate in grid
/// @param _gy Y coordinate in grid
/// @param _level Grid level to check
function Get(_gx, _gy, _level) {
	var grid = _level == GridLevel.FLOOR ? floorGrid : baseGrid;
	
	if(!variable_struct_exists(grid, Key(_gx, _gy))) {
		show_debug_message($"{debugLabel} {GridLevelToString(_level)} does not exist at ({_gx}, {_gy})");
		return noone;
	}
	
	return grid[$ Key(_gx, _gy)];
}

/// @description Removes an entity from specified grid coordinates
/// @param _gx X coordinate in grid
/// @param _gy Y coordinate in grid
/// @param _level Grid level to check
function Remove(_gx, _gy, _level) {
	var grid = _level == GridLevel.FLOOR ? floorGrid : baseGrid;
	var key = Key(_gx, _gy);
	
	if(variable_struct_exists(grid, key)) {
		struct_remove(grid, key);
		show_debug_message($"{debugLabel} Removed {GridLevelToString(_level)} at ({_gx}, {_gy})");
	}
}

/// @description Gets an entity a certain amount of tiles in the direction of given grid coordinates. Returns noone if no entity is found
/// @param _gx X coordinate in grid
/// @param _gy Y coordinate in grid
/// @param _level Grid level to check
/// @param _direction Direction from coordinates to check
/// @param _distance The number of tiles away to check
function GetInDirection(_gx, _gy, _level, _direction, _distance = 1) {
	var dirCoords = GetGridCoordinatesInDirection(_gx, _gy, _direction, _distance);
	show_debug_message($"{debugLabel} Getting {GridLevelToString(_level)} entity {string(_distance)} tiles {DirectionToString(_direction)} of ({_gx}, {_gy})");
	
	return Get(dirCoords.gx, dirCoords.gy, _level);
}

/// @description Gets all entities north, east, south, and west of given grid coordinates
/// @param _gx X coordinate in grid
/// @param _gy Y coordinate in grid
/// @param _level Grid level to check
function GetInProximity(_gx, _gy, _level) {
	var prox = [];
	
	for(var dir = 0; dir < Direction.HEIGHT; dir++) {
		var entity = GetInDirection(_gx, _gy, _level, dir);
		
		if(entity != noone) array_push(prox, entity);
	}
	
	show_debug_message($"{debugLabel} Retrieved {array_length(prox)} entities in proximity of ({_gx}, {_gy})");
	
	return prox;
}

/// @description Checks if an entity is facing another entity 1 tile away
/// @param _e1 The entity to face the other entity
/// @param _e2 The entity to be faced
function IsEntityFacingEntity(_e1, _e2) {
	if(_e1.facing == undefined) {
		show_debug_message($"{debugLabel} '{_e1.label}' does have a specified direction it is facing");
		return false;
	}
	
	if(_e2 == GetInDirection(_e1.gridX, _e1.gridY, _e1.gridLevel, _e1.facing)) return true;
	
	return false;
}

/// @description Helper to parse grid coordinates into keys for grid maps
/// @param _gx X coordinate in grid
/// @param _gy Y coordinate in grid
function Key(_gx, _gy) {
	return string(_gx) + "_" + string(_gy);
}

/// @description Converts world coordinates to grid coordinates
/// @param _x X coordinate in world
/// @param _y Y coordinate in world
function WorldToGrid(_x, _y) {	
	return {
		gx : floor((_x - BOARD_PADDING) / BOARD_TILE_SIZE),
		gy : floor((_y - BOARD_PADDING) / BOARD_TILE_SIZE)
	};
}

/// @description Converts grid coordinates to world coordinates
/// @param _gx X coordinate in grid
/// @param _gy Y coordinate in grid
function GridToWorld(_gx, _gy) {
	return {
		xx : (_gx * BOARD_TILE_SIZE) + BOARD_PADDING,
		yy : (_gy * BOARD_TILE_SIZE) + BOARD_PADDING
	};
}