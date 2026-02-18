if(global.gameState == State.RUNNING) {
	var anyMoving = false;
	
	with(obj_Programmable) {
		if(isMoving) {
			anyMoving = true;
		}
	}
	
	if(!anyMoving) {
		timer -= 1;
		
		if(timer <= 0) {
			with(obj_Programmable) {
				if(currentBlock < array_length(program)) {
					var node = program[currentBlock];
					
					switch(node.type) {
						case BlockType.MOVE:
							MoveForward();
							break;
							
						case BlockType.TURN:
							Turn(node.args.turnDirection);
							break;
					}
					
					currentBlock += 1;
				}
			}
			
			timer = global.stepBuffer;
		}
	}
}