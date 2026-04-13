currentLayerID = "";
newLayerID = "";
spd = 0;
alpha = 1;
phase = 0;
transitioning = false;

function SetLayerAlpha(_layerID, _alpha) {
    if (_layerID == "") exit;
    
    var _elements = layer_get_all_elements(_layerID);
    
    for (var i = 0; i < array_length(_elements); i++) {
        var _el = _elements[i];
        
        try {
            layer_sprite_alpha(_el, _alpha);
        } catch (e) {}
        
        try {
            var _inst = layer_instance_get_instance(_el);
            if (instance_exists(_inst)) {
                _inst.image_alpha = _alpha;
            }
        } catch (e) {}
    }
}

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
    if (currentLayerID == "") return;
    newLayerID = "";
    spd = _spd;
    alpha = 1;
    phase = 0;
    transitioning = true;
}