extends StaticBody2D

var in_range = false
const MENU = preload("res://scenes/shop/shop_menu.tscn")
var menu = null
var player = null

func _ready():
	$RichTextLabel.text = "Press 'e' to open shop"

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		shop_menu()

func shop_menu():
	if in_range and menu == null:
		player.is_active = false
		menu = MENU.instance()
		menu.position = player.position
		menu.playerRef = player
		get_viewport().add_child(menu)
		$RichTextLabel.text = "Press 'e' to close shop"
	else:
		player.is_active = true
		get_viewport().remove_child(menu)
		menu = null
		$RichTextLabel.text = "Press 'e' to open shop"

func _on_Area2D_body_entered(body):
	if "player" in body.name:
		$RichTextLabel.visible = true
		player = body
		in_range = true

func _on_Area2D_body_exited(body):
	if "player" in body.name:
		$RichTextLabel.visible = false
		player = body
		in_range = false
