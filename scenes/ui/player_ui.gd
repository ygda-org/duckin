extends Control

export var time = 0
export var max_time = 100
export var money = 0
export var food = 0
export var ducks = 0

func _process(delta):
	_update()

func _update():
	if($info/money.text.length() != String(money).length()):
		_recenter()
	elif($info/food.text.length() != String(money).length()):
		_recenter()
	elif($info/ducks.text.length() != String(money).length()):
		_recenter()
	
	$info/money.text = String(money)
	$info/food.text = String(food)
	$info/ducks.text = String(ducks)
	
	$timer.value = (time/max_time) * $timer.max_value

func _recenter():
	var length = $info.rect_size.x
	var count = $info.get_child_count()
	var offset = length / (count+1)
	var t_pos = offset
	
	for child in $info.get_children():
		child.rect_position.x = t_pos - (child.rect_size.x/2)
		t_pos += offset
		child.rect_position.y = ($info.rect_size.y - child.rect_size.y)/2

func _set_timer(is_visible):
	$timer.visible = is_visible
