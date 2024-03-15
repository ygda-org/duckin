extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var BASIC_DUCK = preload("res://scenes/wanderingDuck/WanderingDuck.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var amountOfDucks = 30
	var spawnRadius = 1000
	var rng = RandomNumberGenerator.new()
	
	#Ducks can't spawn this close to the player
	var playerBuffer = 300
	
	for i in range(amountOfDucks):
		var newDuck = BASIC_DUCK.instance()
		rng.randomize()
		newDuck.position = Vector2(rng.randf_range(-1.0, 1.0) * spawnRadius, rng.randf_range(-1.0, 1.0) * spawnRadius)
		while newDuck.position.distance_to(get_parent().get_node("player").position) <= playerBuffer:
			rng.randomize()
			newDuck.position = Vector2(rng.randf_range(-1.0, 1.0) * spawnRadius, rng.randf_range(-1.0, 1.0) * spawnRadius)
		
		add_child(newDuck)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
