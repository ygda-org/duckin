extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var health = 10
var maxHealth

# Called when the node enters the scene tree for the first time.
func _ready():
	maxHealth = health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Moves to Vector(0,0) at a speed of 1 unit per second
	var speed = 90 # Change this to increase it to more units/second
	global_position = global_position.move_toward(Vector2(0,0), delta * speed)
	
	if (global_position == Vector2(0, 0)):
		queue_free()
		
func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free()
