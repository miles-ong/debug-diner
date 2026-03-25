if((room == rm_StartRoom || room == rm_Cutscene) && mouse_check_button_released(mb_left) && canClick) {
	canClick = false;
	if(idx == 0) {
		ChangeGameState(GameState.TRANSITIONING);
			
		obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, true, function() {
			layer_set_visible("GameStartInterface", false);
			room_goto(rm_Cutscene);
			idx++;
			obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, false, function() {
				ChangeGameState(GameState.CUTSCENE);
				canClick = true;
			}));
		}));
		
		return;
	}
	
	if(idx == 5) {
		obj_GameController.GoToCurrentLevel();
		return;
	}
	
	idx++;
	canClick = true;
}