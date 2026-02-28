if(isMoving) {
	moveProgress += global.stepSpeed;
	var distance = moveProgress / BOARD_TILE_SIZE;
	x = lerp(startX, endX, distance);
	y = lerp(startY, endY, distance);
	
	if(moveProgress >= BOARD_TILE_SIZE) {
		var oldX = gridX;
		var oldY = gridY;
		
		gridX = targetGridX;
		gridY = targetGridY;
		x = endX;
		y = endY;
		isMoving = false;
		
		obj_GridController.Remove(GridLevel.BASE, oldX, oldY);
		obj_GridController.Set(GridLevel.BASE, gridX, gridY, id);
	}
}