function MouseToPanelGridX() {
	return floor((mouse_x - x) / cellSize);
}

function MouseToPanelGridY() {
	return floor((mouse_y - y + scrollY) / cellSize);
}

function LoadSelectedProgram() {
	blocks = ds_list_create();
	var selectedProgram = currentOwner.program;
}

function SaveSelectedProgram() {
	
}