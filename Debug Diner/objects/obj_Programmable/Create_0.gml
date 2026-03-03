event_inherited();

program = [];
programStack = [];

clickSoundEffects = [];
hoverScale = 0.9;
scaleSpeed = 0.4;

image_speed = 0;
layer = layer_get_id("Entity");

function CountBlocks(nodes) {
    var count = 0;
	
    for(var i = 0; i < array_length(nodes); i++) {
        count++;
		
        if(array_length(nodes[i].body) > 0) count += CountBlocks(nodes[i].body);
    }
	
    return count;
}

function CollectBlockTypes(nodes, map = undefined) {
	var blockTypesUsed = map == undefined ? ds_map_create() : map;
	
	for(var i = 0; i < array_length(nodes); i++) {
		var type = nodes[i].type;
		
		if(!ds_map_exists(blockTypesUsed, type)) ds_map_add(blockTypesUsed, type, true);
		if(array_length(nodes[i].body) > 0) CollectBlockTypes(nodes[i].body, blockTypesUsed);
	}
	
	return blockTypesUsed;
}

function MakeFrame(nodes, index) {
	return { nodes : nodes, index : index };
}