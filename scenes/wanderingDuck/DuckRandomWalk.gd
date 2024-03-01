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
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	walk_ready = true
	walking = false
	randomize()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (happy):
		pass
	elif (interested):
		direction = position.direction_to(seedPos)
		move_and_slide(direction * speed)
	else:
		if walk_ready:
			direction = Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()
			start_timer()
		if walking:
			move_and_slide(direction * speed)
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
