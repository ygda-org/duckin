extends KinematicBody2D

export var speed = 5
var velocity = Vector2(0,0)
var click_position = Vector2(0,0)
var damage = 50
var blast_radius = 100
var click = false


func _ready():
	var dir_to = global_position.direction_to(get_global_mouse_position())
	var distance_to = global_position.distance_to(get_global_mouse_position())
	click_position = get_global_mouse_position()
	
	if click_position.x > 0:
		$Duck.flip_h = true

func _physics_process(delta):
	
	if position.length() <= click_position.length():
		position += click_position.normalized() * speed
	else:
		blow_up()

func blow_up():
	var enemies = get_tree().get_nodes_in_group('Enemy')
	for enemy in enemies:
		var distance = position.distance_to(enemy.global_position)
		if distance <= blast_radius:
			enemy.take_damage(damage)	
	queue_free() 
