debugLabel = "[obj_GridController]";
floorGrid = {};
baseGrid = {};

function Initialize() {
	floorGrid = {};
	baseGrid = {};
	
	with(obj_Entity) {
		var gCoords = other.WorldToGrid(x, y);
		other.Set(gCoords.gx, gCoords.gy, id);
	}
	
	show_debug_message($"{debugLabel} Initialized");
}

function Set(_gx, _gy, _inst) {
	var grid = _inst.gridLevel == GridLevel.FLOOR ? floorGrid : baseGrid;
	grid[$ Key(_gx, _gy)] = _inst;
	show_debug_message($"{debugLabel} Set {GridLevelToString(_inst.gridLevel)} '{_inst.label}' at ({_gx}, {_gy})");
}

function Get(_gx, _gy, _level) {
	var grid = _level == GridLevel.FLOOR ? floorGrid : baseGrid;
	
	if(!variable_struct_exists(grid, Key(_gx, _gy))) {
		show_debug_message($"{debugLabel} {GridLevelToString(_level)} does not exist at ({_gx}, {_gy})");
		return noone;
	}
	
	return grid[$ Key(_gx, _gy)];
}

function Remove(_gx, _gy, _level) {
	var grid = _level == GridLevel.FLOOR ? floorGrid : baseGrid;
	var key = Key(_gx, _gy);
	
	if(variable_struct_exists(grid, key)) {
		struct_remove(grid, key);
		show_debug_message($"{debugLabel} Removed {GridLevelToString(_level)} at ({_gx}, {_gy})");
	}
}

function GetInDirection(_gx, _gy, _level, _direction, _distance = 1) {
	var dirCoords = GetGridCoordinatesInDirection(_gx, _gy, _direction, _distance);
	show_debug_message($"{debugLabel} Getting {GridLevelToString(_level)} entity {string(_distance)} tiles {DirectionToString(_direction)} of ({_gx}, {_gy})");
	
	return Get(dirCoords.gx, dirCoords.gy, _level);
}

function GetInProximity(_gx, _gy, _level) {
	var prox = [];
	
	for(var dir = 0; dir < Direction.HEIGHT; dir++) {
		var entity = GetInDirection(_gx, _gy, _level, dir);
		
		if(entity != noone) array_push(prox, entity);
	}
	
	show_debug_message($"{debugLabel} Retrieved {array_length(prox)} entities in proximity of ({_gx}, {_gy})");
	
	return prox;
}

function IsEntityFacingEntity(_e1, _e2) {
	if(_e1.facing == undefined) {
		show_debug_message($"{debugLabel} '{_e1.label}' does have a specified direction it is facing");
		return false;
	}
	
	if(_e2 == GetInDirection(_e1.gridX, _e1.gridY, _e1.gridLevel, _e1.facing)) return true;
	
	return false;
}

function Key(_gx, _gy) {
	return string(_gx) + "_" + string(_gy);
}

function WorldToGrid(_x, _y) {	
	return {
		gx : floor((_x - BOARD_PADDING) / BOARD_TILE_SIZE),
		gy : floor((_y - BOARD_PADDING) / BOARD_TILE_SIZE)
	};
}

function GridToWorld(_gx, _gy) {
	return {
		xx : (_gx * BOARD_TILE_SIZE) + BOARD_PADDING + BOARD_TILE_SIZE / 2,
		yy : (_gy * BOARD_TILE_SIZE) + BOARD_PADDING + BOARD_TILE_SIZE / 2
	};
}