function Customer(_chairId, _orders, _trait = CustomerTrait.NONE) constructor {
	chairId = _chairId;
	orders = _orders;
	trait = _trait;
	currentOrder = 0;
	isSatisfied = false;
	
	function CompleteOrder() {
		var order = orders[currentOrder];
		order.isComplete = true;
		currentOrder++;
		
		if(currentOrder >= array_length(orders)) isSatisfied = true;
		
		show_debug_message("Customer (Chair " + string(_chairId) + ") Satisfied: " + (isSatisfied ? "True" : "False"));
	}
}

function MealOrder(_meal, _stepsToComplete = undefined, _isBonus = false) constructor {
	meal = _meal;
	stepsToComplete = _stepsToComplete;
	isBonus = _isBonus;
	isComplete = false;
}