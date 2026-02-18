function CreateBlock(xx, yy, type) {
	var block = instance_create_layer(xx, yy, "GameInterface", obj_Block);
	block.type = type;
	block.SetupType();
	
	return block;
}