extends KinematicBody2D

var velocity = Vector2()
export var SPEED = 256
const FOOD = preload("res://scenes/player/duck_food.tscn")
var food = FOOD.instance()
var can_throw = true


func _physics_process(delta):
	player_movement()
	if can_throw and Input.is_action_just_pressed("ui_left_click"):
		throw_food()


func player_movement():
	if Input.is_action_pressed("move_forwards"):
		velocity.y = -1
		$Sprite.flip_v = true
	elif Input.is_action_pressed("move_backwards"):
		velocity.y = 1
		$Sprite.flip_v = false
	else:
		velocity.y = 0
		
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
		$Sprite.flip_h = true
	elif Input.is_action_pressed("move_right"):
		velocity.x = 1
		$Sprite.flip_h = false
	else:
		velocity.x = 0
	velocity = move_and_slide(velocity*SPEED)


func throw_food():
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

func _on_throw_timer_timeout():
	can_throw = true
