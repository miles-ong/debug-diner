if((global.gameState == GameState.PROGRAMMING && global.selectedProgram != id) ||
	global.gameState == GameState.EVENT && highlight) 
	{
		if(array_length(clickSoundEffects) != 0) {
			var index = random_range(0, array_length(clickSoundEffects));
		
			audio_play_sound(clickSoundEffects[index], 0, false);
		}
	
		global.selectedProgram = id;
		highlight = false;
		ChangeGameState(GameState.PROGRAMMING);
		obj_EventController.FireSignal(EventSignal.OBJECTCLICKED, id);
}