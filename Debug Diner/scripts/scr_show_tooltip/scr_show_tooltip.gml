function scr_show_tooltip(_title, _text)
{
    if (!instance_exists(obj_TooltipController)) return;

    with (obj_TooltipController)
    {
        show_tooltip = true;
        tooltip_title = string(_title);
        tooltip_text  = string(_text);
    }
}