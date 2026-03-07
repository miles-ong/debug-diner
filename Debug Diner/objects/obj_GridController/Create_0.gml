debugLabel = "[obj_GridController]";
floorGrid = {};
baseGrid = {};

function Initialize() {
	floorGrid = {};
	baseGrid = {};
	
	with(obj_Floor) {
		var gCoords = other.WorldToGrid(x, y);
		other.SetFloor(gCoords.gx, gCoords.gy, id);
	}
	
	with(obj_Base) {
		var gCoords = other.WorldToGrid(x, y);
		other.SetBase(gCoords.gx, gCoords.gy, id);
	}
	
	show_debug_message($"{debugLabel} Initialized");
}

function Set(_gx, _gy, _inst) {
	var grid = _inst.gridLevel == GridLevel.FLOOR ? floorGrid : baseGrid;
	grid[$ Key(_gx, _gy)] = _inst;
	show_debug_message($"{debugLabel} Set {GridLevelToString(_inst.gridLevel)} ({_inst.label}) at ({_gx}, {_gy})");
}

function Get(_gx, _gy, _level) {
	var grid = _level == GridLevel.FLOOR ? floorGrid : baseGrid;
	
	if(!variable_struct_exists(grid, Key(_gx, _gy))) {
		show_debug_message($"{debugLabel} {GridLevelToString(_level)} does not exist at ({_gx}, {_gy})");
		return noone;
	}
	
	return grid[$ Key(_gx, _gy)];
}

function GetInDirection(_gx, _gy, _level, _direction, _distance = 1) {
	var dirCoords = GetGridCoordinatesInDirection(_gx, _gy, _direction, _distance);
	show_debug_message($"{debugLabel} Getting {GridLevelToString(_level)} entity {string(_distance)} tiles {DirectionToString(_direction)} of ({_gx}, {_gy})");
	
	return Get(dirCoords.gx, dirCoords.gy, _level);
}

function GetInProximity(_gx, _gy, _level) {
	var prox = [];
	
	for(var dir = 0; dir < Direction.HEIGHT; dir++) {
		array_push(prox, GetInDirection(_gx, _gy, _level, dir));
	}
	
	show_debug_message($"{debugLabel} Retrieved {array_length(prox)} entities in proximity of ({_gx}, {_gy})");
	
	return prox;
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