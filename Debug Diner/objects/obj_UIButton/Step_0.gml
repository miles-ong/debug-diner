scale = 1;

if (pulse)
{
    pulseTime += pulseSpeed;
    scale += sin(pulseTime) * pulseAmplitude;
}

if (animateClick)
{
    clickCurveValue = lerp(clickCurveValue, 1, clickCurveSpeed);
    animateClick = clickCurveValue < 1;
    var curveEval = animcurve_channel_evaluate(clickCurveChannelScale, clickCurveValue);
    scale += curveEval;
}