extends Area2D

var speed = 750
var dmg = 100

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.take_damage(dmg)
	queue_free()
