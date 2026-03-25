event_inherited();

label = "Holo-Chair";

switch(facing) {
	case Direction.NORTH: sprite_index = spr_ChairUp; break;
	case Direction.EAST: sprite_index = spr_ChairRight; break;
	case Direction.SOUTH: sprite_index = spr_ChairDown; break;
	case Direction.WEST: sprite_index = spr_ChairLeft; break;
}