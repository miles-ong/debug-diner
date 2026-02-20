if(room == rm_MainMenu) {
	var bounds = obj_MenuBlockBounds.GetBounds();
	
	instance_create_layer(bounds.left + 50, bounds.top + 50, "MenuBlockLayer", obj_MainMenuBlock);
	
	CreateMenuBlock(MenuBlockType.NEXTLEVEL, bounds);
	CreateMenuBlock(MenuBlockType.SETTINGS, bounds);
}