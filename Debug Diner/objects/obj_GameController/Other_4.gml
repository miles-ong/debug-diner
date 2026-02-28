ClearLayers();

global.isDraggingBlock = false;
global.selectedProgram = noone;
global.editingBlockContent = noone;
global.hoveredBlock = noone;
global.hoveredBlockContent = noone;
global.hoveredBlockSlot = noone;
global.hoveredProgrammable = noone;

if(room == rm_MainMenu) {
	global.gameState = GameState.MENUS;
	var bounds = obj_Bounds.GetBounds();
	
	instance_create_layer(bounds.left + 50, bounds.top + 50, "MenuBlock", obj_MainMenuBlock);
	
	CreateMenuBlock(MenuBlockType.LEVELSELECT, bounds);
	CreateMenuBlock(MenuBlockType.CONTINUE, bounds);
	CreateMenuBlock(MenuBlockType.SETTINGS, bounds);
	
	return;
}

obj_LevelController.StartLevel();