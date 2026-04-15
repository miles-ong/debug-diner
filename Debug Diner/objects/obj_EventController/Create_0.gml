// --- Setup ---
debugLabel = "[EventController]";

// --- Event Tracking ---
event = undefined;
nextActionIndex = 1;
previousGameState = GameState.MENUS;

function Initialize(_event) {
	event = _event
	nextActionIndex = 0;
	
	if(event == undefined) {
		show_debug_message($"{debugLabel} No event exists for this level");
		return;
	}
	
	if(array_length(event) == 0) {
		show_debug_log($"{debugLabel} Event must have at least one action attached to it");
		return;
	}
	
	show_debug_message($"{debugLabel} Initialized this level's event with {array_length(event)} actions");
}

function FireSignal(_signalType, _signaler = undefined) {
	if (event == undefined) {
		show_debug_message($"{debugLabel} No event exists");
		return;
	}
	
	if (nextActionIndex >= array_length(event)) {
		show_debug_message($"{debugLabel} No more actions exist in the event sequence");
		return;
	}
	
	show_debug_message($"{debugLabel} Fired '{EventSignalToString(_signalType)}' signal");
	
	var next = event[nextActionIndex];
	
	if (next.signal == _signalType) {
		if (_signalType == EventSignal.OBJECTCLICKED || 
			_signalType == EventSignal.BLOCKCONNECTED || 
			_signalType == EventSignal.BLOCKDISCONNECTED) {
				var desired = next.desiredSignaler;
				
				if(desired == undefined) {
					show_debug_message($"{debugLabel} The desired signaler for this action cannot be undefined");
					return;
				}
				
				if(_signaler.object_index != desired && !object_is_ancestor(_signaler.object_index, desired)) {
					return;
				}
		}
		
	//(inst.object_index == obj_Waiter || object_is_ancestor(inst.object_index, obj_Waiter)))
		
		previousGameState = global.gameState;
		ChangeGameState(GameState.EVENT);
		next.action.Execute();
		nextActionIndex++;
		show_debug_message($"{debugLabel} Executed action");
	}
}