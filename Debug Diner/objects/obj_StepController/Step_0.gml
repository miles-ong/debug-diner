if(global.gameState != GameState.READING && global.gameState != GameState.EXECUTING) exit;

var anyMoving = false;

with(obj_Entity) {
	if(moving) anyMoving = true;
}

if(!anyMoving) {
	ChangeGameState(GameState.READING, true);
	timer -= 1;
}

if(global.gameState == GameState.READING && timer <= 0) {
	timer = global.stepBuffer;
	var complete = ReadPrograms();
	
	if(complete) {
		show_debug_message($"{debugLabel} Program complete");
		obj_LevelController.FinalizeLevel();
		exit;
	}
	
	ResolveSteps();
}