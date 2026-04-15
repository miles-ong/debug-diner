function Customer(_chairId, _bonus = false) {
	return {
		chairId : _chairId,
		bonus : _bonus,
		served : false
	};
}