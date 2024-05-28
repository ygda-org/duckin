extends KinematicBody2D

var velocity = Vector2()
export var SPEED = 120  # velocity of 2 when 60 FPS
const FOOD = preload("res://scenes/player/duck_food.tscn")
const DUCK = preload("res://scenes/Explosive Duck/Explosive Duck.tscn")
var food = FOOD.instance()
var can_throw = true
export var food_count = 10
export var duck_count = 0
export var money = 0
export var is_active = true
export var is_attacking = false
export var can_attack = false

func _physics_process(delta):
	if !is_active:
		return
	
	update_ui()
	
	if is_attacking:
		if Input.is_action_just_pressed("ui_left_click"):
			throw_duck()
		return
		
	player_movement(delta)
	if can_throw and food_count > 0 and Input.is_action_just_pressed("ui_left_click"):
		throw_food()
		change_food(-1)
	
	#test buying food
	#if Input.is_action_just_pressed("ui_up"):
	#	spend_money(1)

func update_ui():
	$player_ui.money = money
	$player_ui.food = food_count
	$player_ui.ducks = duck_count

func player_movement(delta):
	if Input.is_action_pressed("move_forwards"):
		velocity.y = -1 * SPEED * delta
		$Sprite.flip_v = true
	elif Input.is_action_pressed("move_backwards"):
		velocity.y = 1 * SPEED * delta
		$Sprite.flip_v = false
	else:
		velocity.y = 0
		
	if Input.is_action_pressed("move_left"):
		velocity.x = -1 * SPEED * delta
		$Sprite.flip_h = true
	elif Input.is_action_pressed("move_right"):
		velocity.x = 1 * SPEED * delta
		$Sprite.flip_h = false
	else:
		velocity.x = 0
	velocity = move_and_slide(velocity*SPEED)


func throw_food():
	var dir_to = global_position.direction_to(get_global_mouse_position())
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
	
func throw_duck():
	if duck_count > 0:
		var duck = DUCK.instance()
		get_parent().add_child(duck)
		addDucks(-1)

func _on_throw_timer_timeout():
	can_throw = true
	
func addDucks(duckNum): # Called in duck_food.gd to add ducks to the players duck count on collection
	duck_count += duckNum
	
func change_food(change): # Call with positive value to add food, negative value to remove food.
	food_count += change

func change_money(change): # Call with positive value to add money, negative value to remove money.
	money += change

func spend_money(n): #buying food
	if money>=n:
		change_money(-n)
		change_food(n)
	#print(money, food_count)

func _duck_ping():
	$scene_changer._duck_ping()
