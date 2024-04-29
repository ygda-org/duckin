extends RigidBody2D

var dir = Vector2()
var has_started = false
var speed = 256
var velocity = Vector2()
var ducks = []

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
	$hapyRadius/happyShape.disabled = false

func _on_Radius_body_entered(body):
	if "Duck" in body.name:
		body._interest(position)


func _on_hapyRadius_body_entered(body):
	if "Duck" in body.name:
		ducks.append(body)
		body._happy()
	if "player" in body.name: #collection!
		body.addDucks(len(ducks))
		for duck in ducks:
			duck.queue_free()
		ducks = []
