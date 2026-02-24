grid = {};

function Fill() {
	grid = {};
	
	with(obj_Floor) {
		var gCoords = other.WorldToGrid(x, y);
		
		var data = {
			walkable : isWalkable,
			deadly : isDeadly
		}
		
		other.Set(GridLevel.FLOOR, gCoords.gridX, gCoords.gridY, data);
		show_debug_message("Added Floor at " + string(gCoords.gridX) + ", " + string(gCoords.gridY));
	}
	
	with(obj_Base) {
		var gCoords = other.WorldToGrid(x, y);
		
		var data = {
			collision : canCollide
		};
		
		other.Set(GridLevel.BASE, gCoords.gridX, gCoords.gridY, data);
		show_debug_message("Added Base at " + string(gCoords.gridX) + ", " + string(gCoords.gridY));
	}
	
	with(obj_Programmable) {
		var gCoords = other.WorldToGrid(x, y);
		var level = layer_get_name(layer) == "Base" ? GridLevel.BASE : GridLevel.FLOOR;
		
		var data = {
			collision : canCollide
		};
		
		other.Set(level, gCoords.gridX, gCoords.gridY, data);
		show_debug_message("Added Programmable at " + string(gCoords.gridX) + ", " + string(gCoords.gridY));
	}
}

function Get(level, gridX, gridY) {
	show_debug_message(string(gridX) + ", " + string(gridY));
	
	if(Exists(level, gridX, gridY)) return grid[$ Key(level, gridX, gridY)];
	
	return noone;
}

function Set(level, gridX, gridY, data) {
	grid[$ Key(level, gridX, gridY)] = data;
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