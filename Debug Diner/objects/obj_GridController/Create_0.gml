grid = {};

function Fill() {
	grid = {};
	var controller = id;
	
	with(obj_Floor) {
		var gCoords = other.WorldToGrid(x, y);
		
		var data = {
			walkable : isWalkable,
			deadly : isDeadly
		}
		
		other.Set(GridLevel.FLOOR, gCoords.gridX, gCoords.gridY, data);
	}
	
	with(obj_Base) {
		var gCoords = other.WorldToGrid(x, y);
		
		var data = {
			collision : canCollide
		};
		
		other.Set(GridLevel.BASE, gCoords.gridX, gCoords.gridY, data);
	}
	
	with(obj_Programmable) {
		var gCoords = other.WorldToGrid(x, y);
		var level = layer_get_name(layer) == "Base" ? GridLevel.BASE : GridLevel.FLOOR;
		
		var data = {
			collision : canCollide
		};
		
		other.Set(level, gCoords.gridX, gCoords.gridY, data);
	}
}

function Get(level, gridX, gridY) {
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
		gridX : round(xx / CELL_SIZE),
		gridY : round(yy / CELL_SIZE)
	};
}

Fill();