extends KinematicBody2D

export var speed = 450
var velocity = Vector2(0,0)
var click_position = Vector2(0,0)
var damage = 50
var blast_radius = 100
var click = false
var player = null

func _ready():
	click_position = get_global_mouse_position()
	
	if click_position.x > 0:
		$Duck.flip_h = true
	
	_update_player()

func _physics_process(delta):
	
	if position.length() <= click_position.length():
		position += click_position.normalized() * speed * delta
	else:
		blow_up()

func blow_up():
	var enemies = get_tree().get_nodes_in_group('Enemy')
	for enemy in enemies:
		var distance = position.distance_to(enemy.global_position)
		if distance <= blast_radius:
			enemy.take_damage(damage)	
			player.change_money(1)
	player._duck_ping()
	queue_free()

func _update_player():
	for node in get_parent().get_children():
		if node.name == "player":
			player = node
