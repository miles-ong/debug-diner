var bounds = obj_MainMenuBlockBounds.GetBounds();

if(isDragging) {
	flingX = mouse_x - prevMouseX;
	flingY = mouse_y - prevMouseY;
	prevMouseX = mouse_x;
	prevMouseY = mouse_y;
	x = mouse_x;
	y = mouse_y;
	
	ClampToBounds(bounds);
	
	if(!mouse_check_button(mb_left)) {
		global.draggingBlock = noone;
		isDragging = false;
		layer = layer_get_id("MenuBlock");
		
		velocityX = flingX;
		velocityY = flingY;
		var currentSpeed = point_distance(0, 0, velocityX, velocityY);
		
		if(currentSpeed > maxSpeed) {
			velocityX = (velocityX / currentSpeed) * maxSpeed;
			velocityY = (velocityY / currentSpeed) * maxSpeed;
		}
		
		var main = instance_place(x, y, obj_MainMenuBlock);
		
		if(main != noone) {
			main.Connect(id);
		}
		else {
			var hit = instance_place(x, y, obj_MenuBlock);
			
			while(hit != noone && hit != id) {
				var dir = point_direction(hit.x, hit.y, x, y);
				x += lengthdir_x(4, dir);
				y += lengthdir_y(4, dir);
				hit = instance_place(x, y, obj_MenuBlock);
			}
		}
		
		ClampToBounds(bounds);
	}
}
else if(!isConnected) {
	x += velocityX;
	
	var hitBlock = instance_place(x, y, obj_MenuBlock);
	var hitMain = instance_place(x, y, obj_MainMenuBlock);
	
	if((hitBlock != noone && hitBlock != id) || hitMain != noone) {
		x -= velocityX;
		velocityX = -velocityX;
	}
	
	y += velocityY;
	
	hitBlock = instance_place(x, y, obj_MenuBlock);
	hitMain = instance_place(x, y, obj_MainMenuBlock);
	
	if((hitBlock != noone && hitBlock != id) || hitMain != noone) {
		y -= velocityY;
		velocityY = -velocityY;
	}
	
	BounceOffBounds(bounds);
	ClampToBounds(bounds);
	
	var currentSpeed = point_distance(0, 0, velocityX, velocityY);
	
	if(currentSpeed > wanderSpeed) {
		velocityX = lerp(velocityX, (velocityX / currentSpeed) * wanderSpeed, 0.05);
		velocityY = lerp(velocityY, (velocityY / currentSpeed) * wanderSpeed, 0.05);
	}
}