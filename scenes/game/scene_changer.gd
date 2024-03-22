extends Node

var player = null
var ui = null
var max_time = 100
var game_name = "game_scene"

func _ready():
	max_time = $Timer.wait_time
	player = get_parent()
	for child in player.get_children():
		if child.name == "player_ui":
			ui = child
	ui.max_time = max_time

func _on_Timer_timeout():
	var curr = get_tree().current_scene
	if curr.name == game_name:
		curr.change_scenes()

func _process(delta):
	ui.time = max_time - $Timer.time_left
