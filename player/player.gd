extends CharacterBody2D

@export var speed = 400
@export var Bullet : PackedScene

var muzzle_right_vector = Vector2(90, 0)
var muzzle_left_vector = Vector2(-90, 0)
var muzzle_rotation_degrees = 0

	

func _physics_process(_delta):
	# handle player movement
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	move_and_slide()
	
	
	if input_direction.x == 0 and input_direction.y == 0:
		$Sprite.stop()
	elif input_direction.x <= 0 && input_direction.y == 0:
		$Muzzle.position = muzzle_left_vector
		muzzle_rotation_degrees = -180
		shoot()
		$Sprite.play("left")
	elif input_direction.x >= 0 && input_direction.y == 0:
		$Muzzle.position = muzzle_right_vector
		muzzle_rotation_degrees = 0
		shoot()
		$Sprite.play("right")
	elif input_direction.y <= 0 && input_direction.x == 0:
		shoot()
		$Sprite.play("up")
	elif input_direction.y >= 0 && input_direction.x == 0:
		shoot()
		$Sprite.play("down")

		
func shoot():
	var b = Bullet.instantiate()
	b.transform = $Muzzle.transform
	b.position.y -= 20
	b.rotation_degrees = muzzle_rotation_degrees	
	add_child(b)

