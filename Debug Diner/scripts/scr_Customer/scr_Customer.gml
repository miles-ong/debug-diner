function Customer(_orders, _trait = CustomerTrait.NONE) constructor {
	orders = _orders;
	trait = _trait;
	currentOrder = 0;
	isSatisfied = false;
	
	function CompleteOrder() {
		var order = orders[currentOrder];
		currentOrder++;
		
		if(currentOrder >= array_length(orders)) isSatisfied = true;
	}
	
}

function MealOrder(_meal, _stepsToComplete = undefined, _isBonus = false) constructor {
	meal = _meal;
	stepsToComplete = _stepsToComplete;
	isBonus = _isBonus;
	isComplete = false;
}