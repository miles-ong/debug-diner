event_inherited();

switch (facing)
{
    case Direction.NORTH: sprite_index = spr_WaiterNorth; break;
    case Direction.EAST:  sprite_index = spr_WaiterEast;  break;
    case Direction.SOUTH: sprite_index = spr_WaiterSouth; break;
    case Direction.WEST:  sprite_index = spr_WaiterWest;  break;
}

// 悬停时显示 tooltip
if(global.gameState == GameState.PROGRAMMING) {
	tutorial_highlight_active = instance_exists(obj_TooltipController) && !tutorial_waiter_dismissed;
	
	if (tutorial_highlight_active && global.hoveredProgrammable == id)
	{
	    scr_show_tooltip(tooltip_title, tooltip_text);
	}

	// 点击 waiter 后，结束高亮和提示
	if (tutorial_highlight_active && global.hoveredProgrammable == id && mouse_check_button_pressed(mb_left))
	{
	    tutorial_waiter_dismissed = true;
	    tutorial_highlight_active = false;
	}
}