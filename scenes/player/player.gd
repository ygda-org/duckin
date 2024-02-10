extends KinematicBody2D

var velocity = Vector2()
var speed = 256
const FOOD = preload("res://scenes/player/duck_food.tscn")
var food = FOOD.instance()
var can_throw = true

func _physics_process(delta):
	if Input.is_action_pressed("ui_move_up"):
		velocity.y = -1
		$Sprite.flip_v = true
	elif Input.is_action_pressed("ui_move_down"):
		velocity.y = 1
		$Sprite.flip_v = false
	else:
		velocity.y = 0
	
	if Input.is_action_pressed("ui_move_left"):
		velocity.x = -1
		$Sprite.flip_h = true
	elif Input.is_action_pressed("ui_move_right"):
		velocity.x = 1
		$Sprite.flip_h = false
	else:
		velocity.x = 0
	
	if can_throw and Input.is_action_just_pressed("ui_left_click"):
		var dir_to = position.direction_to(get_viewport().get_mouse_position())
		var distance_to = position.distance_to(get_viewport().get_mouse_position())
		food = FOOD.instance()
		food.position = global_position + dir_to*45
		food.dir = dir_to
		get_parent().add_child(food)
		
		if(dir_to.y <= -dir_to.x and dir_to.y <= dir_to.x):
			$Sprite.flip_v = true
		elif(dir_to.y > -dir_to.x and dir_to.y > dir_to.x):
			$Sprite.flip_v = false
		elif(dir_to.y > dir_to.x and dir_to.y <= -dir_to.x):
			$Sprite.flip_v = false
			$Sprite.flip_h = true
		elif(dir_to.y > -dir_to.x and dir_to.y <= dir_to.x):
			$Sprite.flip_v = false
			$Sprite.flip_h = false
		
		can_throw = false
		$throw_timer.start()

	velocity = move_and_slide(velocity*speed)


func _on_throw_timer_timeout():
	can_throw = true
