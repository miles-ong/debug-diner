if(isMoving) {
	moveProgress += global.stepSpeed;
	var distance = moveProgress / CELL_SIZE;
	x = lerp(startX, endX, distance);
	y = lerp(startY, endY, distance);
	
	if(moveProgress >= CELL_SIZE) {
		gridX = targetGridX;
		gridY = targetGridY;
		x = endX;
		y = endY;
		isMoving = false;
	}
}