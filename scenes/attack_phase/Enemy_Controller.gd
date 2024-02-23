extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var BASIC_ENEMY = preload("res://attack_phase/Enemies/Basic_Enemy/Basic_Enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(3, 4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Timer_timeout():
	var basicEnemy = BASIC_ENEMY.instance()
		
	var dist = 210
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var angle = rng.randi_range(0, 360)
	
	var xPos = dist * cos(angle * 2 * PI / 360)
	var yPos = dist * sin(angle * 2 * PI / 360)
		
	basicEnemy.position = Vector2(xPos, yPos)
	
	add_child(basicEnemy)
