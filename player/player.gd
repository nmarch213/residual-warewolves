extends CharacterBody2D

@export var speed = 400
	

func _physics_process(_delta):
	# handle player movement
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	move_and_slide()
	
	# handle player animation based on movement
	handle_animation(input_direction)

func handle_animation(input_direction):
	if input_direction.x == 0 and input_direction.y == 0:
		$Sprite.stop()
	elif input_direction.x <= 0 && input_direction.y == 0:
		$Sprite.play("left")
	elif input_direction.x >= 0 && input_direction.y == 0:
		$Sprite.play("right")
	elif input_direction.y <= 0 && input_direction.x == 0:
		$Sprite.play("up")
	elif input_direction.y >= 0 && input_direction.x == 0:
		$Sprite.play("down")
