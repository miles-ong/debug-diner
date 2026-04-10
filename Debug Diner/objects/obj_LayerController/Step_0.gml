if(!transitioning) exit;

if(phase == 0) {
	alpha -= spd;
	
	if(alpha <= 0) {
		alpha = 0;
		layer_set_visible(currentLayerID, false);
		currentLayerID = newLayerID;
		
		if(currentLayerID == "") {
			transitioning = false;
			exit;
		}
		else {
			layer_set_visible(currentLayerID, true);
		}
		
		phase = 1;
	}
}
else if(phase == 1) {
	alpha += spd;
	
	if(alpha >= 1) {
		alpha = 1;
		transitioning = false;
	}
}