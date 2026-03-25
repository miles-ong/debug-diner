event_inherited();

label = "Holo-Chair";

switch(facing) {
	case Direction.NORTH: break;
	case Direction.EAST: sprite_index = spr_ChairRight; break;
	case Direction.SOUTH: break;
	case Direction.WEST: sprite_index = spr_ChairLeft; break;
}