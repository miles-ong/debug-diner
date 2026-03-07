enum GameState {
	MENUS,
	TRANSITIONING,
	PROGRAMMING,
	READING,
	EXECUTING
}

function ChangeGameState(_newState, suppressEqualWarning = false) {
	if(global.gameState == _newState) {
		show_debug_message($"[scr_GameState] Game state is already {GameStateToString(newState)}");
		return;
	}
	
	var oldState = global.gameState;
	global.gameState = _newState;
	show_debug_message($"[scr_GameState] Changed game state from {GameStateToString(oldState)} to {GameStateToString(_newState)}");
}

function GameStateToString(_gameState) {
	switch(_gameState) {
		case GameState.MENUS: return "Menus";
		case GameState.TRANSITIONING: return "Transitioning";
		case GameState.PROGRAMMING: return "Programming";
		case GameState.READING: return "Reading";
		case GameState.EXECUTING: return "Executing";
	}
}