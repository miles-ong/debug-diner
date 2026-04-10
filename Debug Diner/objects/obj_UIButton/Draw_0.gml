event_inherited();

var targetOpacity = isHovered ? hoverOpacity : 1;
var buttonScale = scale;
var iconScale = scale;
var textScale = scale;
image_alpha = lerp(image_alpha, targetOpacity, hoverSpeed);

draw_sprite_ext(sprite_index, image_index, x, y, originalScaleX * buttonScale, originalScaleY * buttonScale, image_angle, image_blend, image_alpha);

if (iconSprite != noone) draw_sprite_ext(iconSprite, 0, x, y, iconScale, iconScale, 0, c_white, image_alpha);

if (text != "")
{
    draw_set_alpha(image_alpha);
    draw_set_color(c_white);
    draw_set_font(textFont);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(x, y, text, textScale, textScale, 0);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
