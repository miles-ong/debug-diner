draw_self();

var currLevel = global.currentLevel;

if(currLevel == undefined) return;

var text = success ? "Success!" : "Nice Try!";
draw_set_color(c_white);
draw_set_font(fo_UILarge);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y + 4, text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);