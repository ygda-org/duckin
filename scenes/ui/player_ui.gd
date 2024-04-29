extends Control

export var time = 0
export var max_time = 100
export var money = 0
export var food = 0
export var ducks = 0

func _process(delta):
	_update()

func _update():
	$info/money.text = String(money)
	$info/food.text = String(food)
	$info/ducks.text = String(ducks)
	
	$timer.value = (time/max_time) * $timer.max_value
