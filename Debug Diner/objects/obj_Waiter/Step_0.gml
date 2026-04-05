event_inherited();

switch (facing)
{
    case Direction.NORTH: sprite_index = spr_WaiterNorth; break;
    case Direction.EAST:  sprite_index = spr_WaiterEast;  break;
    case Direction.SOUTH: sprite_index = spr_WaiterSouth; break;
    case Direction.WEST:  sprite_index = spr_WaiterWest;  break;
}

is_hovered = point_in_rectangle(
    mouse_x, mouse_y,
    bbox_left, bbox_top, bbox_right, bbox_bottom
);

// 只有房间里有 TooltipController 且还没点击关闭时，保持高亮
tutorial_highlight_active = instance_exists(obj_TooltipController) && !tutorial_waiter_dismissed;

// 悬停时显示 tooltip
if (tutorial_highlight_active && is_hovered)
{
    scr_show_tooltip(tooltip_title, tooltip_text);
}

// 点击 waiter 后，结束高亮和提示
if (tutorial_highlight_active && is_hovered && mouse_check_button_pressed(mb_left))
{
    tutorial_waiter_dismissed = true;
    tutorial_highlight_active = false;
}