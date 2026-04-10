currentLayerID = "";
newLayerID = "";
spd = 0;
alpha = 1;
phase = 0;
transitioning = false;

function TransitionLayers(_previousLayerID, _newLayerID, _spd) {
	currentLayerID = _previousLayerID;
	newLayerID = _newLayerID;
	spd = _spd;
	alpha = 1;
	phase = 0;
	transitioning = true;
}

function FadeLayerIn(_layerID, _spd) {
	currentLayerID = _layerID;
	spd = _spd;
	alpha = 0;
	phase = 1;
	layer_set_visible(currentLayerID, true);
	transitioning = true;
}

function FadeCurrentLayerOut(_spd) {
	if(currentLayerID == "") return;

	newLayerID = "";
	spd = _spd;
	alpha = 1;
	phase = 0;
	transitioning = true;
}