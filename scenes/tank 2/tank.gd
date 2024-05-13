extends KinematicBody2D

export var speed = 300
var click_position = Vector2(0, 0)
var click = false
var hp = 200

func _ready():
	click_position = Vector2(position.x, position.y)

func _physics_process(delta):
	if hp > 0:
		hp -= 5
		print(hp)
	
	if Input.is_action_just_pressed("left_click"):
		click_position = get_global_mouse_position()
		click = true

	var target_position = (click_position - position).normalized()
	if click:
		var direction = (click_position - position).normalized()
		position += direction * speed * delta
		if position.distance_to(click_position) < 3:
			tank()
			click = false

func tank():
	if hp >= 100:
		tank_ability()
	if hp <= 0:
		queue_free()
	
		
func tank_ability():
	# draw agrro of enemies. Dunno how to make
	pass
