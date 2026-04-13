// --- Initialize Layers at Alpha 0 to fix flickering issue ---
var layers = ["RegionSelectInterface", "LevelSelectInterface"]

for(var i = 0; i < array_length(layers); i++) {
	var _id = layers[i];
	layer_set_visible(_id, true);
	SetLayerAlpha(_id, 0);
	layer_set_visible(_id, false);
}