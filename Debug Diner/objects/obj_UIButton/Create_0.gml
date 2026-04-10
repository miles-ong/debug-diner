isEnabled = false;
isHovered = false;
animateClick = false;

hoverOpacity = 0.7;
hoverSpeed = 0.15;
clickCurveSpeed = 0.1;

pulseTime = 0;

clickCurve = animcurve_get(cu_ButtonClick);
clickCurveValue = 0;
clickCurveChannelScale = animcurve_get_channel(clickCurve, "scale");

scale = 1;
originalScaleX = image_xscale;
originalScaleY = image_yscale;