class_name Enemy extends CharacterBody2D

@export var run_speed = 100
@export var health = 100

var player = null

func _physics_process(_delta):
	if !player:
		player = get_node("/root/Test/Player")
	else:
		# move towards player
		velocity = position.direction_to(player.position) * run_speed

	handle_animation()
	move_and_slide()



func handle_animation():
	var horizontal = velocity.x
	var vertical = velocity.y

	if velocity.length() == 0:
		$Sprite.stop()
		return

	if vertical < horizontal:
		if velocity.x > 0:
			$Sprite.play("right")
		else:
			$Sprite.play("left")
	else:
		if velocity.y > 0:
			$Sprite.play("down")
		else:
			$Sprite.play("up")
