success = false;

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
					PlaySoundEffect(sfx_TapLow);
					
					if(previousLevelIndex != noone) obj_GameController.SetCurrentLevel(previousLevelIndex);
					break;
					
				case 1:
					var level = obj_GameController.GetLevel(obj_GameController.currentLevelIndex);
					PlaySoundEffect(sfx_TapEnter);
					
					if(level.unlocked) obj_GameController.GoToCurrentLevel();
					break;
					
				case 2:
					var nextLevelIndex = obj_GameController.GetNextLevelIndex();
					PlaySoundEffect(sfx_TapHigh);
					
					if(nextLevelIndex != noone) obj_GameController.SetCurrentLevel(nextLevelIndex);
					break;
			}
			break;
			
		case ButtonLayer.LEVELRESULT:
			switch(_id) {
				case 0:
					obj_GameController.ReturnToMainMenu();
					break;
				
				case 1:
				    var nextIndex = obj_GameController.GetNextLevelIndex();
				    var nextLevel = obj_GameController.GetLevel(nextIndex);
    
				    if(nextLevel != noone && nextLevel.unlocked && success) {
				        obj_GameController.SetCurrentLevel(nextIndex);
				        obj_GameController.GoToCurrentLevel();
				    }
				    else {
				        obj_GameController.GoToCurrentLevel();
				    }
				    break;
			}
	}
}