var controller = obj_LayerController;

if(controller.transitioning && layer == layer_get_id(controller.currentLayerID)) {
	show_debug_message("Hi");
	image_alpha = obj_LayerController.alpha;
	draw_self();
	exit;
}