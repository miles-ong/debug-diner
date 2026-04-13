var t = current_time * animSpeed;
image_angle = sin(t * 0.7) * rockAmount;
image_xscale = 1 + sin(t * 1.3) * scaleAmount;
image_yscale = image_xscale;