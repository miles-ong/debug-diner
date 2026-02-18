if(global.selectedProgram == noone) {
	visible = false;
	return;
}

visible = true;

if(currentProgram != global.selectedProgram) {
	SaveSelectedProgram();
	currentProgram = global.selectedProgram;
	LoadSelectedProgram();
}