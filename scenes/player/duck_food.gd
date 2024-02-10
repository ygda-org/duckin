extends RigidBody2D

var dir = Vector2()
var has_started = false
var speed = 256
var velocity = Vector2()

func _physics_process(delta):
	if has_started and !$Particles2D.emitting:
		queue_free()
	
	velocity = delta*dir*speed
	translate(velocity)

func _on_travel_timer_timeout():
	$Sprite.visible = false
	$Particles2D.emitting = true
	has_started = true
	speed = 0
	$Radius/CollisionShape2D.disabled = false

func _on_Radius_area_entered(area):
	pass
