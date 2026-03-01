var targetOpacity = isHovered ? hoverOpacity : 1;
var spriteScale = 1;
var textScale = 1;

image_alpha = lerp(image_alpha, targetOpacity, hoverSpeed);

if(animateClick) {
	clickCurveValue = lerp(clickCurveValue, 1, clickCurveSpeed);
	animateClick = clickCurveValue < 1;
	
	var curveEval = animcurve_channel_evaluate(clickCurveChannelScale, clickCurveValue);
	image_xscale = originalScaleX + curveEval;
	image_yscale = originalScaleY + curveEval;
	spriteScale += curveEval;
	textScale += curveEval;
}

draw_self();

if(spriteIndex != noone) {
	draw_sprite_ext(spriteIndex, 0, x, y, spriteScale, spriteScale, 0, c_white, targetOpacity);
}

if(text != "") {
	draw_set_alpha(targetOpacity);
	draw_set_color(c_white);
	draw_set_font(textFont);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text_transformed(x, y, text, textScale, textScale, 0);
	
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}