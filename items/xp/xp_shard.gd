extends Area2D



func _on_body_entered(body:Node2D):
	if body.is_in_group("Player"):
		body.gain_experience(5)
		self.queue_free()



