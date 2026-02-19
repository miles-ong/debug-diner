cellSize = BLOCK_HEIGHT;
programBlock = noone;
currentProgram = noone;

function SnapToGrid(block) {
	block.x = round((block.x - x) / cellSize) * cellSize + x;
	block.y = round((block.y - y) / cellSize) * cellSize + y;
}

function LoadSelectedProgram() {
	if(currentProgram == noone) {
		return;
	}
	
	Clear();
	
	programBlock = instance_create_layer(x + BLOCK_HEIGHT, y + BLOCK_HEIGHT, "BlockLayer", obj_Block);
	programBlock.type = BlockType.PROGRAM;
	programBlock.SetupType();
	
	var previousBlock = programBlock;
	
	for(var i = 0; i < array_length(currentProgram.program); i++) {
		var block = instance_create_layer(previousBlock.nextSlot.x, previousBlock.nextSlot.y, "BlockLayer", obj_Block);
		block.Deserialize(currentProgram.program[i]);
		previousBlock.nextBlock = block;
		block.parentBlock = previousBlock;
		previousBlock = block;
	}
}

function SaveSelectedProgram() {
	if(currentProgram == noone) {
		return;
	}
	
	currentProgram.program = [];
	var block = programBlock.nextBlock;
	
	while(block != noone) {
		array_push(currentProgram.program, block.Serialize());
		block = block.nextBlock;
	}
}

function Clear() {
	with(obj_Block) {
		instance_destroy();
	}
	
	with(obj_BlockSlot) {
		instance_destroy();
	}
	
	with(obj_BlockArgument) {
		instance_destroy();
	}
	
	programBlock = noone;
}