if(instance_number(obj_GameController) > 1) {
	instance_destroy();
	return;
}

debugLabel = "[obj_GameController]";
levels = [];

northAmericaLevels = [
	CreateLevel(
		"Level 1-1", 
		spr_TrophyBurger, 
		true, 
		CreateTask(TaskType.GUIDETOTABLE), 
		undefined, 
		undefined, 
		rm_Level1_1
	),
	CreateLevel(
		"Level 1-2", 
		noone, 
		false, 
		CreateTask(TaskType.GUIDETOTABLE), 
		CreateTask(TaskType.LESSTHANBLOCKS, 3), 
		undefined, 
		rm_Level1_2
	),
	CreateLevel(
		"Level 1-3",
		noone,
		false,
		CreateTask(TaskType.GUIDETOTABLE, 2),
		CreateTask(TaskType.USEBLOCK, BlockType.LOOP),
		CreateTask(TaskType.LESSTHANBLOCKS, 8),
		rm_Level1_3
	),
];
southAmericaLevels = [];
europeLevels = [];
asiaLevels = [];
africaLevels = [];
australiaLevels = [];


currentRegion = LevelRegion.NORTHAMERICA;
currentLevelIndex = 0;
continueLevel = 0;

function SetLevelRegion(region) {
	levels = [];
	
	switch(region) {
		case LevelRegion.NORTHAMERICA: levels = northAmericaLevels; break;
		case LevelRegion.SOUTHAMERICA: levels = southAmericaLevels; break;
		case LevelRegion.EUROPE: levels = europeLevels; break;
		case LevelRegion.ASIA: levels = asiaLevels; break;
		case LevelRegion.AFRICA: levels = africaLevels; break;
		case LevelRegion.AUSTRALIA: levels = australiaLevels; break;
	}
}

function SetCurrentLevel(index) {
	if(index < 0 || index > array_length(levels) - 1) return;
	
	currentLevelIndex = index;
	global.currentLevel = levels[index];
}

function GetLevel(index) {
	if(index < 0 || index > array_length(levels) - 1) return;
	
	return levels[index];
}

function GetNextLevelIndex() {
	var length = array_length(levels);
	
	if(length == 0) return undefined;
	
	return (currentLevelIndex + 1) % array_length(levels);
}

function GetPreviousLevelIndex() {
	var length = array_length(levels)
	
	if(length == 0) return undefined;
	
	return (currentLevelIndex - 1 + length) % array_length(levels);
}

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

function GoToCurrentLevel() {
	GoToLevel(currentLevelIndex);
}

function ReturnToMainMenu() {
	layer_set_visible("LevelInterface", false);
	layer_set_visible("LevelResult", false);
	layer_set_visible("MainMenuInterface", true);
	
	room_goto(rm_MainMenu);
}

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