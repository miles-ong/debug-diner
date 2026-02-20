if(instance_number(obj_GameController) > 1) {
	instance_destroy();
	return;
}

levels = [
	instance_create_layer(0, 0, "Controllers", obj_Level1_1)
];

function GoToLevel(index) {
	if(index < 0 || index > array_length(levels) - 1) return;

	room_goto(levels[index].targetRoom);
}

function ReturnToMainMenu() {
	room_goto(rm_MainMenu);
}