function CreateArgument(xx, yy, type) {
	var arg = instance_create_layer(xx, yy, "ArgumentsLayer", obj_BlockArgument);
	arg.type = type;
	arg.SetupType();
}

function CreateTask(type) {
	var task = instance_create_layer(x, y, "Controllers", obj_LevelTask);
	task.type = type;
	task.SetupType();
}

function CreateMenuBlock(type, bounds) {
	var boundsX;
	var boundsY;
	var spriteWidth = 0;
	
	switch(type) {
		case MenuBlockType.NEXTLEVEL: spriteWidth = sprite_get_width(spr_NextLevelBlock); break;
		case MenuBlockType.SETTINGS: spriteWidth = sprite_get_width(spr_SettingsBlock); break;
	}
	
	do {
		boundsX = random_range(bounds.left, bounds.right - spriteWidth);
		boundsY = random_range(bounds.top, bounds.bottom - MENU_BLOCK_HEIGHT);
	}
	until(instance_place(x, y, obj_MenuBlock) == noone && instance_place(x, y, obj_MainMenuBlock) == noone)
	
	var block = instance_create_layer(boundsX, boundsY, "MenuBlockLayer", obj_MenuBlock);
	block.type = type;
	block.SetupType();
}