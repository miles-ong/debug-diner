if (!transitioning) exit;

if (phase == 0) {
    alpha -= spd;

    if (alpha <= 0) {
        alpha = 0;
        SetLayerAlpha(currentLayerID, alpha);
        layer_set_visible(currentLayerID, false);
        currentLayerID = newLayerID;

        if (currentLayerID == "") {
            transitioning = false;
            exit;
        } else {
            layer_set_visible(currentLayerID, true);
        }
		
		phase = 1;
    } else {
        SetLayerAlpha(currentLayerID, alpha);
    }
}
else if (phase == 1) {
    alpha += spd;

    if (alpha >= 1) {
        alpha = 1;
        transitioning = false;
    }
    SetLayerAlpha(currentLayerID, alpha);
}