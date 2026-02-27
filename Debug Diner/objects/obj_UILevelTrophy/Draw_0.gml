draw_self();

var trophy = global.currentLevel.trophy;

if(trophy == noone) return;

draw_sprite(trophy, 0, x, y);