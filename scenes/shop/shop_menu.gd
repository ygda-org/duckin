extends Node2D

onready var player = get_node("/root/player_test/player")
onready var money_display = $Panel/Panel/money_display

func _ready():
	money_display.text = "Money : " + str(player.money)

#func _process(delta):
#	pass

func _on_Button_button_down():
	if player.money > 0:
		player.food_count += 1
		player.money -= 1
		money_display.text = "Money : " + str(player.money)
