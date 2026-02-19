if(instance_number(obj_GameController) > 1) {
	instance_destroy();
	return;
}

persistent = true;

levels = [
	instance_create_layer(0, 0, "Controllers", obj_Level1_1)
];

currentLevel = 0;

function GoToLevel(index) {
	currentLevel = index;
	room_goto(levels[currentLevel].room);
}