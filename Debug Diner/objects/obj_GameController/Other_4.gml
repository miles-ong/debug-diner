ClearLayers();
global.selectedProgram = noone;

if(room == rm_MainMenu) {
	var bounds = obj_Bounds.GetBounds();
	
	instance_create_layer(bounds.left + 50, bounds.top + 50, "MenuBlock", obj_MainMenuBlock);
	
	CreateMenuBlock(MenuBlockType.LEVELSELECT, bounds);
	CreateMenuBlock(MenuBlockType.CONTINUE, bounds);
	CreateMenuBlock(MenuBlockType.SETTINGS, bounds);
}