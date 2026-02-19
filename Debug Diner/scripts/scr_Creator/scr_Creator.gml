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