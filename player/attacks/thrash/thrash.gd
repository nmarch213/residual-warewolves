extends Attack 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$DamageArea.disabled = true
	pass


func _on_area_2d_body_entered(body:Node2D):
	if body.is_in_group("enemy"):
		body.take_damage(calc_damage())



func _on_timer_timeout():
	$Sprite.play()
	$DamageArea.disabled = false
	pass # Replace with function body.

