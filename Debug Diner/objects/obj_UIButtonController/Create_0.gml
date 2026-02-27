if(instance_number(obj_UIButtonController) > 1) {
	instance_destroy();
	return;
}

function HandleButtonPress(_id, _layer) {
	switch(_layer) {
		case ButtonLayer.LEVELSELECT:
			switch(_id) {
				case 0:
					var previousLevelIndex = obj_GameController.GetPreviousLevelIndex();
					
					if(previousLevelIndex != noone) obj_GameController.SetCurrentLevel(previousLevelIndex);
					break;
					
				case 1:
					obj_GameController.GoToCurrentLevel();
					break;
					
				case 2:
					var nextLevelIndex = obj_GameController.GetNextLevelIndex();
					
					if(nextLevelIndex != noone) obj_GameController.SetCurrentLevel(nextLevelIndex);
					break;
			}
	}
}