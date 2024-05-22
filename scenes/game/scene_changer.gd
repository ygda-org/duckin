extends Node

var player = null
var ui = null
var max_time = 0  # Placeholder value
var game_name = "game_scene"
var recruit_name = "RecruitScene"
var attack_name = "Node2D"

func _ready():
	max_time = $Timer.wait_time
	player = get_parent()
	for child in player.get_children():
		if child.name == "player_ui":
			ui = child
	ui.max_time = max_time
	_phase()

func _on_Timer_timeout():
	var curr = get_tree().current_scene
	if player.duck_count > 0:
		curr.change_scenes()
	else:
		$Timer.start()

func _process(_delta):
	ui.time = ui.max_time - $Timer.time_left

func _phase():
	var curr = get_tree().current_scene
	if curr.name == game_name:
		if(curr.get_child(0).name == recruit_name):
			ui._set_timer(true)
			$Timer.start()
		elif(curr.get_child(0).name == attack_name):
			ui._set_timer(false)

func _duck_ping():
	if(player != null):
		var curr = get_tree().current_scene
		if(player.duck_count <= 0 && curr.get_child(0).name == attack_name):
			curr.change_scenes()
