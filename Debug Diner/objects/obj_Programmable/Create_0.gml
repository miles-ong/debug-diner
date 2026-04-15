event_inherited();

// --- Settings ---
hoverScale = 0.9;
scaleSpeed = 0.4;
clickSoundEffects = [];

// --- Program ---
program = [];
programStack = [];

// --- Setup ---
image_speed = 0;

function EvaluateCondition(_condition) {
	switch(_condition.type) {
		case BlockType.COND_AHEAD_IS:
			var occupant = obj_GridController.GetInDirection(gridX, gridY, gridLevel, facing);
			var options = ["Empty", "Table", "Chair", "Counter", "Printer", "Waiter"];
			var objType = options[_condition.args.objectType];
			
			if(occupant == noone) return objType == "Empty";
			
			return occupant.conditionLabel == objType;
	}
	
	return false;
}

/// @description Returns the number of blocks used in the program
/// @param nodes Recursive code blocks within parent blocks
function CountBlocks(nodes) {
    var count = 0;
	
    for(var i = 0; i < array_length(nodes); i++) {
        count++;
		
        if(array_length(nodes[i].body) > 0) count += CountBlocks(nodes[i].body);
    }
	
    return count;
}

/// @description Returns an array containing all block types used in the program
/// @param nodes Recursive code blocks within parent blocks
/// @param map Map to load block types into, if left undefined, map will be created on its own
function CollectBlockTypes(nodes, map = undefined) {
	var blockTypesUsed = map == undefined ? ds_map_create() : map;
	
	for(var i = 0; i < array_length(nodes); i++) {
		var type = nodes[i].type;
		
		if(!ds_map_exists(blockTypesUsed, type)) ds_map_add(blockTypesUsed, type, true);
		if(array_length(nodes[i].body) > 0) CollectBlockTypes(nodes[i].body, blockTypesUsed);
	}
	
	return blockTypesUsed;
}

/// @description Creates a section of code blocks from the program for the step controller to iterate over
/// @param nodes Section of code blocks
/// @param index Current index within the section
function MakeFrame(nodes, index) {
	return { nodes : nodes, index : index };
}