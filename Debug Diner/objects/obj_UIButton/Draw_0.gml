var targetOpacity = isHovered ? hoverOpacity : 1;

image_alpha = lerp(image_alpha, targetOpacity, hoverSpeed);

if(animateClick) {
	clickCurveValue = lerp(clickCurveValue, 1, clickCurveSpeed);
	animateClick = clickCurveValue < 1;
	
	var curveEval = animcurve_channel_evaluate(clickCurveChannelScale, clickCurveValue);
	image_xscale = originalScaleX + curveEval;
	image_yscale = originalScaleY + curveEval;
}

draw_self();