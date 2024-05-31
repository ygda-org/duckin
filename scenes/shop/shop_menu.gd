extends Node2D

var playerRef = null
onready var money_display = $Panel/Panel/money_display

func _ready():
	money_display.text = "Money : " + str(playerRef.money)

#func _process(delta):
#	pass

func _on_Button_button_down():
	if playerRef.money > 0:
		playerRef.food_count += 1
		playerRef.money -= 1
		money_display.text = "Money : " + str(playerRef.money)
