# use for every duck object that wanders around
extends KinematicBody2D

var speed = 100
var timer = 2.0
var walk_ready = true
var walking = false
var interested = false
var happy = false
var seedPos = Vector2()
var direction = Vector2(rand_range(-10, 10), rand_range(-10, 10)).normalized()
var chance = 0
var chancing = false
var idle = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("Wander")
	walk_ready = true
	walking = false
	idle = false
	randomize()
	
func chancer():
	chance = 0
	chancing = false
	var random_num = rand_range(0, 100)
	if random_num > 0 and random_num < 30:
		print("idle")
		walk_ready = false
		walking = false
		idle = true
	else:
		print("walking")
		walk_ready = false
		walking = true
		idle = false
	chancing = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (happy):
		$anim.play("default")
	elif (interested):
		direction = position.direction_to(seedPos)
		move_and_slide(direction * speed)
	else:
		if idle:
			speed = 0
		elif walk_ready:
			direction = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()
			chancer()
		elif walking:
			speed = 100
			move_and_slide(direction * speed)
			
func _physics_process(delta):
	if chancing:
		chance += 0.01
		var random_num = rand_range(0, 100)
		if chance > random_num:
			idle = false
			walking = false
			walk_ready = true
func start_timer():
	# Start the timer called WalkTimer to wait for 2 seconds
	$WalkTimer.start(timer)
	walking = true
	walk_ready = false

func _interest(pos):
	seedPos = pos
	interested = true

func _happy():
	$HappyTimer.start()

func _on_WalkTimer_timeout():
	# When the timer finishes, choose a new direction and restart the timer
	print("changing direction")
	walk_ready = true
	walking = false


func _on_HappyTimer_timeout():
	interested = false
	happy = true


