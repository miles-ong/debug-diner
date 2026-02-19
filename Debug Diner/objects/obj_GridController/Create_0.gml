grid = {};

function Fill() {
	// unfinished
}

function Get(gridX, gridY) {
	if(Exists(gridX, gridY)) return grid[$ Key(gridX, gridY)];
	
	return noone;
}

function Set(gridX, gridY, data) {
	grid[$ Key(gridX, gridY)] = data;
}

function Remove(gridX, gridY) {
	variable_struct_remove(grid, Key(gridX, gridY));
}

function Exists(gridX, gridY) {
	return variable_struct_exists(grid, Key(gridX, gridY));
}

function Key(gridX, gridY) {
	return string(gridX + "_" + gridY);
}