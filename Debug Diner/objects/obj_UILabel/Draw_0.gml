draw_self();
draw_set_alpha(image_alpha);

draw_set_colour(c_white);
draw_set_font(textFont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(x, y + 4, text);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_alpha(1);