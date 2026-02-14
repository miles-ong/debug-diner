if(global.gameState == State.RUNNING) {
	var anyMoving = false;
	
	with(obj_waiter) {
		if(moving) {
			anyMoving = true;
		}
	}
	
	if(!anyMoving) {
		timer -= 1;
		
		if(timer <= 0) {
			with(obj_waiter) {
				if(currCommand < array_length(program)) {
					var command = program[currCommand];
					
					switch(command.type) {
						case Command.MOVE:
							move_forward();
							break;
						case Command.TURN:
							turn(command.dir);
							break;
					}
					
					currCommand += 1;
				}
			}
			
			timer = global.stepBuffer;
		}
	}
}