event_inherited();

draw_self();

var bounce = sin(current_time / 300) * 4;
draw_sprite(spr_Burger, 0, x, y - sprite_height * 0.5 + bounce);

if(highlight) shader_reset();