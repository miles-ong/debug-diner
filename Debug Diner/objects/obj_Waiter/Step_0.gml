event_inherited();

switch(facing) {
	case Direction.NORTH: sprite_index = spr_WaiterNorth; break;
	case Direction.EAST: sprite_index = spr_WaiterEast; break;
	case Direction.SOUTH: sprite_index = spr_WaiterSouth break;
	case Direction.WEST: sprite_index = spr_WaiterWest; break;
}