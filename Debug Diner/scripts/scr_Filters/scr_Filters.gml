function Fade(_spd, _color, _fadeIn, _callback = undefined) constructor {
	spd = _spd;
	color = _color;
	fadeIn = _fadeIn;
	callback = _callback;
	alpha = fadeIn ? 0 : 1;
	finished = false;
	
	function Update() {
		alpha += fadeIn ? spd : -spd;
		alpha = clamp(alpha, 0, 1);
		
		if(alpha == 0 || alpha == 1) {
			finished = true;
			
			if(callback != undefined) callback();
		}
	}
	
	function Draw() {
		draw_set_alpha(alpha);
		draw_set_color(color);
		draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
		draw_set_alpha(1);
	}
}