show_debug_message("Start Pressed");

if(global.gameState == GameState.RUNNING) {
	show_debug_message("Already running...");
	
	return;
}

if(global.editingArgument != noone) global.editingArgument.owner.OnArgumentChanged();
with(obj_ProgrammingPanel) SaveSelectedProgram();
with(obj_Programmable) programStack = [MakeFrame(program, 0)];

global.gameState = GameState.RUNNING;

show_debug_message("Switched to running")