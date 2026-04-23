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
	
	if(currentProgram.isExecutable) {
		programBlock = instance_create_layer(x + BLOCK_HEIGHT, y + BLOCK_HEIGHT, "Block", obj_Block);
		programBlock.type = BlockType.PROGRAM;
		programBlock.Initialize();
	
		var previousBlock = programBlock;
	
		for(var i = 0; i < array_length(currentProgram.program); i++) {
			var block = instance_create_layer(previousBlock.nextSlot.x, previousBlock.nextSlot.y, "Block", obj_Block);
			block.Deserialize(currentProgram.program[i]);
			block.LinkToSlot(previousBlock.nextSlot, true);
			previousBlock = block;
		}
	}
	else {
		var defs = variable_struct_get_names(currentProgram.functions);
		
		for(var i = 0; i < array_length(defs); i++) {
			var def = defs[i];
			var func = currentProgram.functions[$ def];
			var defBlock = instance_create_layer(func.xx, func.yy, "Block", obj_Block);
			defBlock.type = BlockType.DEFINE;
			defBlock.Initialize();
			defBlock.argDef.value = def;
			var previousBlock = noone;
			
			for(var j = 0; j < array_length(func.body); j++) {
				var block = instance_create_layer(defBlock.childSlot.x, defBlock.childSlot.y, "Block", obj_Block);
				block.Deserialize(func.body[j]);
				
				if(previousBlock == noone) block.LinkToSlot(defBlock.childSlot, true);
				else block.LinkToSlot(previousBlock.nextSlot, true);
				
				previousBlock = block;
			}
		}
	}
}

function SaveSelectedProgram() {
	if(currentProgram == noone) {
		return;
	}
	
	if(currentProgram.isExecutable) {
		currentProgram.program = [];
		var block = programBlock.nextBlock;
	
		while(block != noone) {
			array_push(currentProgram.program, block.Serialize());
			block = block.nextBlock;
		}
	}
	else {
		var defBlocks = [];
		
		with(obj_Block) {
			if(type == BlockType.DEFINE) array_push(defBlocks, id);
		}
		
		for(var i = 0; i < array_length(defBlocks); i++) {
			var block = defBlocks[i];
			var def = block.argDef.value;
			
			var func = {
				xx : block.x,
				yy : block.y,
				body : []
			}
			
			var child = block.childBlock;
			
			while(child != noone) {
				array_push(func.body, child.Serialize());
				child = child.nextBlock;
			}
			
			currentProgram.functions[$ def] = func;
		}
	}
}

function Clear() {
	with(obj_Block) {
		instance_destroy();
	}
	
	with(obj_BlockSlot) {
		instance_destroy();
	}
	
	with(obj_BlockContent) {
		instance_destroy();
	}
	
	programBlock = noone;
}