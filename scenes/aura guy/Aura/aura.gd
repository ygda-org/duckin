extends KinematicBody2D

export var speed = 300
var click_position = Vector2(0, 0)
var click = false
var damage = 10
var blast_radius = 100
var max_ticks = 10
var ticks = 0

func _ready():
	click_position = Vector2(position.x, position.y)

func _physics_process(delta):
	if ticks < max_ticks:
		ticks += 1
		print(ticks)

	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		click = true

	if click:
		var direction = (click_position - position).normalized()
		position += direction * speed * delta 
		if position.distance_to(click_position) < 3:
			aura()
			click = false


func aura():
	while ticks < 10:
		var enemies = get_tree().get_nodes_in_group('Enemiesssss')
		for enemy in enemies:
			var distance = position.distance_to(enemy.global_position)
			if distance <= blast_radius:
				enemy.take_damage(damage)
	queue_free()



