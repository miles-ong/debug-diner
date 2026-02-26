for(var i = array_length(activeFilters) - 1; i >= 0; i--) {
	var filter = activeFilters[i];
	
	filter.Update();
	filter.Draw();
	
	if(filter.finished) array_delete(activeFilters, i, 1);
}