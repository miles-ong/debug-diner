if(instance_number(obj_GameController) > 1) {
	instance_destroy();
	return;
}

levels = [
	instance_create_layer(0, 0, "Controllers", obj_Level1_1)
];

function GoToLevel(index) {
	if(index < 0 || index > array_length(levels) - 1) return;
	
	var level = { targetRoom : levels[index].targetRoom };
	
	obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, true, method(level, function() {
		room_goto(targetRoom);
		obj_ScreenFilter.AddFilter(new Fade(0.02, c_black, false));
		layer_destroy_instances(layer_get_id("MenuBlockLayer"));
		layer_destroy_instances(layer_get_id("MenuBlockDraggingLayer"));
		layer_set_visible("MainMenuInterface", false);
		layer_set_visible("LevelInterface", true);
	})));
}

function ReturnToMainMenu() {
	room_goto(rm_MainMenu);
}