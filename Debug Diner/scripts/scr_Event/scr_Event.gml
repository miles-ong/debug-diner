#region Event Signal
enum EventSignal {
	LEVELSTARTED,
	LEVELCOMPLETED,
	DIALOGUEFINISHED,
	OBJECTCLICKED,
	BLOCKPLACED,
	BLOCKCONNECTED,
	BLOCKDISCONNECTED
}

function EventSignalToString(_signal) {
	switch(_signal) {
		case EventSignal.LEVELSTARTED: return "Level Started";
		case EventSignal.LEVELCOMPLETED: return "Level Completed";
		case EventSignal.DIALOGUEFINISHED: return "Dialogue Finished";
		case EventSignal.OBJECTCLICKED: return "Object Clicked";
		case EventSignal.BLOCKPLACED: return "Block Placed";
		case EventSignal.BLOCKCONNECTED: return "Block Connected";
		case EventSignal.BLOCKDISCONNECTED: return "Block Disconnected";
	}
}
#endregion

/// @description Creates an action to be executed within an event sequence
/// @param _signal The EventSignal that triggers this action
/// @param _action The action to be executed
/// @param _desiredSignaler The object desired to signal (Use only for OBJECTCLICKED, BLOCKCONNECTED, and BLOCKDISCONNECTED)
function EventAction(_signal = undefined, _action, _desiredSignaler = undefined, _desiredBlockType = undefined) {
	return {
		signal : _signal,
		action : _action,
		desiredSignaler : _desiredSignaler,
		desiredBlockType : _desiredBlockType
	};
}

function ExecuteAction(_action) {
	if(is_array(_action)) {
		for(var i = 0; i < array_length(_action); i++) {
			_action[i].Execute();
		}
	}
	else {
		_action.Execute();
	}
}

/// @description Creates a dialogue box with a character
/// @param _text The text to be displayed
/// @param _characterSprite The sprite to be displayed next to the dialogue box, mark undefined for no character sprite
/// @param _position The position of the character sprite relative to the box
/// @param _color The color tint of the dialogue box | DEFAULT = DialogueColor.WHITE
/// @param _talkingBuffer The higher this value is, the slower the character will talk | DEFAULT = 4
/// @param _font The font to draw the text in | DEFAULT = fo_UILarge
function Dialogue(_text, _characterSprite, _position, _color = DialogueColor.WHITE, _talkingBuffer = 4, _font = fo_UILarge) constructor {
	text = _text;
	characterSprite = _characterSprite;
	position = _position;
	color = _color;
	talkingBuffer = _talkingBuffer;
	font = _font;

	function Execute() {
		var box = instance_create_layer(0, 0, "Dialogue", obj_DialogueBox);
		box.Initialize(text, characterSprite, position, color, talkingBuffer, font);
	}
}

function Highlight(_target) constructor {
	target = _target;
	
	function Execute() {
		if(!variable_instance_exists(target, "highlight")) {
			show_debug_message("[Event] Cannot highlight objects that do not inherit obj_MainParent");
			return;
		}
		
		target.highlight = true;
	}
}

function Unhighlight(_target) constructor {
	target = _target;
	
	function Execute() {
		if(!variable_instance_exists(target, "highlight")) {
			show_debug_message("[Event] Cannot unhighlight objects that do not inherit obj_MainParent");
			return;
		}
		
		target.highlight = false;
		ChangeGameState(obj_EventController.previousGameState);
	}
}

function End() constructor {
	function Execute() {
		ChangeGameState(obj_EventController.previousGameState);
		show_debug_message("[Event] Ended event through action");
	}
}

function Custom(_func) constructor {
	func = _func;
	
	function Execute() {
		func();
	}
}