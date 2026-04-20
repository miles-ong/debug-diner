var scale = 1;
var baseW = 1920;
var baseH = 1080;

surface_resize(application_surface, baseW, baseH);
window_set_size(baseW * scale, baseH * scale);
window_center();

UnlockAllLevels();
SetRegionLevels(LevelRegion.NORTHAMERICA);
SetCurrentLevel(0);