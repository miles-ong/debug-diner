grid = {};

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