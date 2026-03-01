type = MenuBlockType.LEVELSELECT;
name = "";
isDragging = false;
isConnected = false;
wanderSpeed = 2;
maxSpeed = 10;
velocityX = lengthdir_x(wanderSpeed, random(360));
velocityY = lengthdir_y(wanderSpeed, random(360));
prevMouseX = 0;
prevMouseY = 0;
flingX = 0;
flingY = 0;

function Initialize(_type) {
	type = _type;
	
	switch(type) {
		case MenuBlockType.LEVELSELECT: name = "Level Select"; break;
		case MenuBlockType.CONTINUE: name = "Continue"; break;
		case MenuBlockType.SETTINGS: name = "Settings"; break;
	}
}

function BounceOffBounds(bounds) {
	if(x < bounds.left) {
		x = bounds.left;
		velocityX = -velocityX;
	}
	
	if(x + sprite_width > bounds.right) {
		x = bounds.right - sprite_width;
		velocityX = -velocityX;
	}
	
	if(y < bounds.top) {
		y = bounds.top;
		velocityY = -velocityY;
	}
	
	if(y + sprite_height > bounds.bottom) {
		y = bounds.bottom - sprite_height;
		velocityY = -velocityY;
	}
}

function ClampToBounds(bounds) {
	x = clamp(x, bounds.left, bounds.right - sprite_width);
	y = clamp(y, bounds.top, bounds.bottom - sprite_height);
}