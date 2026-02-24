if(isMoving) {
	moveProgress += global.stepSpeed;
	var distance = moveProgress / BOARD_TILE_SIZE;
	x = lerp(startX, endX, distance);
	y = lerp(startY, endY, distance);
	
	if(moveProgress >= BOARD_TILE_SIZE) {
		gridX = targetGridX;
		gridY = targetGridY;
		x = endX;
		y = endY;
		isMoving = false;
	}
}