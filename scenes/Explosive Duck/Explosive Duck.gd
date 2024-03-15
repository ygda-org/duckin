extends KinematicBody2D

export var speed = 300
var velocity = Vector2(0,0)
var click_position = Vector2(0,0)
var damage = 50
var blast_radius = 100
var click = false


func _ready():
	click_position = Vector2(position.x,position.y)

func _physics_process(delta):
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		click = true
	
	var target_position = (click_position - position).normalized()
	if click == true:
		if position.distance_to(click_position) > 3:
			move_and_slide(target_position * speed)
		else:
			blow_up()
			click = false

func blow_up():
	var enemies = get_tree().get_nodes_in_group('Enemiesssss')
	for enemy in enemies:
		var distance = position.distance_to(enemy.global_position)
		if distance <= blast_radius:
			enemy.take_damage(damage)	
	queue_free() 
