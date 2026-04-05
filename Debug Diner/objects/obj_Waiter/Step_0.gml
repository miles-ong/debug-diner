event_inherited();

switch(facing) {
	case Direction.NORTH: sprite_index = spr_WaiterNorth; break;
	case Direction.EAST: sprite_index = spr_WaiterEast; break;
	case Direction.SOUTH: sprite_index = spr_WaiterSouth break;
	case Direction.WEST: sprite_index = spr_WaiterWest; break;
}

is_hovered = point_in_rectangle(
    mouse_x, mouse_y,
    bbox_left, bbox_top, bbox_right, bbox_bottom
);

if (is_hovered)
{
    scr_show_tooltip(tooltip_title, tooltip_text);
}