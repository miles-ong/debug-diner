success = false;
alphaTimer = 0;
callback = undefined;

if(instance_number(obj_UIButtonController) > 1) {
	instance_destroy();
	return;
}

function HandleButtonPress(_id, _layer) {
	switch(_layer) {
		case ButtonLayer.REGIONSELECT:
			obj_GameController.SetRegionLevels(_id);
			obj_GameController.SetCurrentLevel(0);
			obj_LayerController.TransitionLayers("RegionSelectInterface", "LevelSelectInterface", 0.05);
			break;
			
		case ButtonLayer.LEVELSELECT:
			switch(_id) {
				case 0:
					PlaySoundEffect(sfx_TapLow);
					var prevIdx = obj_GameController.GetPrevLevelIndex();
					obj_GameController.SetCurrentLevel(prevIdx);
					break;
					
				case 1:
					if(global.currentLevel.unlocked) {
						PlaySoundEffect(sfx_TapEnter);
						obj_GameController.GoToCurrentLevel();
					}
					else {
						PlaySoundEffect(sfx_Undraggable);
					}
					
					break;
					
				case 2:
					PlaySoundEffect(sfx_TapHigh);
					var nextIdx = obj_GameController.GetNextLevelIndex();
					obj_GameController.SetCurrentLevel(nextIdx);
					break;
			}
			break;
			
		case ButtonLayer.LEVELRESULT:
			switch(_id) {
				case 0:
					obj_GameController.ReturnToMainMenu();
					break;
				
				case 1:
					if(!success) {
						obj_GameController.GoToCurrentLevel();
						break;
					}
					
				    var nextIdx = obj_GameController.GetNextLevelIndex();
					
					if(nextIdx == 0) {
						var nextRegion = obj_GameController.GetNextRegion(global.currentRegion);
						obj_GameController.SetRegionLevels(nextRegion);
						obj_GameController.GoToCurrentLevel();
					}
					else {
						obj_GameController.GoToLevel(nextIdx);
					}
 
				    break;
			}
	}
}