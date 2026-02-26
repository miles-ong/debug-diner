switch(facing) {
	case Direction.NORTH: draw_sprite(spr_WaiterNorth, 0, x, y); break;
	case Direction.EAST: draw_sprite(spr_WaiterEast, 0, x, y); break;
	case Direction.SOUTH: draw_sprite(spr_WaiterSouth, 0, x, y); break;
	case Direction.WEST: draw_sprite(spr_WaiterWest, 0, x, y); break;
}