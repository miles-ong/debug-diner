if(!clicked && highlight) {
	clicked = true;
	highlight = false;
	PlaySoundEffect(sfx_Door);
	ChangeGameState(GameState.PROGRAMMING);
	obj_EventController.FireSignal(EventSignal.OBJECTCLICKED, id);
}