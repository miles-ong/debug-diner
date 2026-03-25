if(instance_number(obj_GameController) > 1) {
	instance_destroy();
	return;
}

// --- Setup ---
debugLabel = "[obj_GameController]";
levels = [];

#region Levels
northAmericaLevels = [
	CreateLevel(
		"Level 1-1", 
		spr_TrophyBurger, 
		true, 
		CreateTask(TaskType.GUIDETOTABLE), 
		undefined, 
		undefined, 
		rm_Level1_1
	)
];
#endregion
#region Regions
southAmericaLevels = [];
europeLevels = [];
asiaLevels = [];
africaLevels = [];
australiaLevels = [];
#endregion

// --- Tracking ---
currentRegion = LevelRegion.NORTHAMERICA;
currentLevelIndex = 0;
continueLevel = 0;

/// @description Fills the available levels with the levels from the given region
/// @param _region The region to load levels from
function SetLevelRegion(_region) {
	levels = [];
	
	switch(_region) {
		case LevelRegion.NORTHAMERICA: levels = northAmericaLevels; break;
		case LevelRegion.SOUTHAMERICA: levels = southAmericaLevels; break;
		case LevelRegion.EUROPE: levels = europeLevels; break;
		case LevelRegion.ASIA: levels = asiaLevels; break;
		case LevelRegion.AFRICA: levels = africaLevels; break;
		case LevelRegion.AUSTRALIA: levels = australiaLevels; break;
	}
}

/// @description Sets the current level to a level from levels using a given index. If the index is out of bounds, the current level doesn't change
/// @param _index The index to access
function SetCurrentLevel(_index) {
	if(_index < 0 || _index > array_length(levels) - 1) return;
	
	currentLevelIndex = _index;
	global.currentLevel = levels[_index];
}

/// @description Gets the level from levels using a given index
/// @param _index The index to access
function GetLevel(_index) {
	if(_index < 0 || _index > array_length(levels) - 1) return;
	
	return levels[_index];
}

/// @description Gets the next level's index. If the index goes out of bounds, wrap back to the first level in levels
function GetNextLevelIndex() {
	var length = array_length(levels);
	
	if(length == 0) return undefined;
	
	return (currentLevelIndex + 1) % array_length(levels);
}

/// @description Gets the previous level's index. If the index goes out of bounds, wrap back to the last level in levels
function GetPreviousLevelIndex() {
	var length = array_length(levels)
	
	if(length == 0) return undefined;
	
	return (currentLevelIndex - 1 + length) % array_length(levels);
}

/// @description Loads a level from levels using a given index and enters the level's room
/// @param The index to access
function GoToLevel(index) {
	if(index < 0 || index > array_length(levels) - 1) return;
	
	var level = { targetRoom : levels[index].targetRoom };
	
	obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, true, method(level, function() {
		room_goto(targetRoom);
		obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, false));
		layer_set_visible("LevelSelectInterface", false);
		layer_set_visible("MainMenuInterface", false);
		layer_set_visible("LevelInterface", true);
	})));
}

/// @description Goes to the currently selected level
function GoToCurrentLevel() {
	GoToLevel(currentLevelIndex);
}

/// @description Goes back to the main menu room
function ReturnToMainMenu() {
	layer_set_visible("LevelInterface", false);
	layer_set_visible("LevelResult", false);
	layer_set_visible("MainMenuInterface", true);
	
	room_goto(rm_MainMenu);
}

/// @description Clears all instances from potentially persistent layers
function ClearLayers() {
	layer_destroy_instances("MenuBlock");
	layer_destroy_instances("MenuBlockDragging");
	layer_destroy_instances("BlockSlot");
	layer_destroy_instances("Block");
	layer_destroy_instances("BlockContent");
	layer_destroy_instances("BlockSlotDragging");
	layer_destroy_instances("BlockDragging");
	layer_destroy_instances("BlockContentDragging");
}

SetLevelRegion(LevelRegion.NORTHAMERICA);
SetCurrentLevel(0);