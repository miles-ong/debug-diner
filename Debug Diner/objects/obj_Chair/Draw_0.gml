event_inherited();

draw_self();

if(customer != undefined) {
	var customerSprite, customerX, customerY;
	
	switch(facing) {
		case Direction.NORTH:
			customerSprite = spr_MaleCustomerUp;
			customerX = 0;
			customerY = -32;
			break;
		case Direction.EAST:
			customerSprite = spr_MaleCustomerRight;
			customerX = 8;
			customerY = -28;
			break;
		case Direction.SOUTH:
			customerSprite = spr_MaleCustomerDown;
			customerX = 0;
			customerY = -16;
			break;
		case Direction.WEST:
			customerSprite = spr_MaleCustomerLeft;
			customerX = -4;
			customerY = -28;
			break;
	}
	
	draw_sprite(customerSprite, 0, x + customerX, y + customerY);
}

if(highlight) {
	DrawHighlightArrow();
	shader_reset();
}