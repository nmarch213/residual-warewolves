extends CharacterBody2D

@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	handle_animation(input_direction)

func _physics_process(_delta):
	get_input()
	move_and_slide()

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
