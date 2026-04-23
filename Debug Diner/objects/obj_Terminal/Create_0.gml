event_inherited();

label = "Terminal";
clickSoundEffects = [ sfx_RobotBeep1, sfx_RobotBeep2 ];

SetupEntity("Terminal", GridLevel.BASE, true, true, 25, 90);

isExecutable = false;
functions = {};

function AddFunction(_def, _x = 0, _y = 0) {
	var def = _def;
	
	if(variable_struct_exists(functions, def)) def = GetUniqueFunctionDefinition(_def);
	
	functions[$ def] = {
		xx : _x,
		yy : _y,
		body : []
	}
	
	return def;
}

function RemoveFunction(_def) {
	if(variable_struct_exists(functions, _def)) variable_struct_remove(functions, _def);
}

function GetUniqueFunctionDefinition(_def) {
	var unique = _def;
	var i = 1;
	
	while(variable_struct_exists(functions, unique)) {
		unique = _def + string(i++);
	}
	
	return unique;
}

function ModifyFunctionDefinition(_prevDef, _newDef) {
	if(_prevDef == _newDef) return;
	if(!variable_struct_exists(functions, _prevDef)) return;
	
	var data = functions[$ _prevDef];
	functions[$ _newDef] = data;
	variable_struct_remove(functions, _prevDef);
}