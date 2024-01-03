extends CharacterBody2D

@export var speed = 400
@export var Bullet : PackedScene

var muzzle_right_vector = Vector2(90, 0)
var muzzle_left_vector = Vector2(-90, 0)
var bullet_rotation_degrees = 0


func _physics_process(_delta):
	# handle player movement
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	move_and_slide()
	
	
	if input_direction.x == 0 and input_direction.y == 0:
		$Sprite.stop()
	elif input_direction.x <= 0 && input_direction.y == 0:
		$Sprite.play("left")
		
		# position muzzle on the left size of the player
		$Muzzle.position = muzzle_left_vector
		
		# update this so the bullet is rotated to face forward when shot
		bullet_rotation_degrees = -180
	elif input_direction.x >= 0 && input_direction.y == 0:
		$Sprite.play("right")
		
		# position muzzle on the right size of the player
		$Muzzle.position = muzzle_right_vector
		
		# update this so the bullet is rotated to face forward when shot
		bullet_rotation_degrees = 0
	elif input_direction.y <= 0 && input_direction.x == 0:
		$Sprite.play("up")
	elif input_direction.y >= 0 && input_direction.x == 0:
		$Sprite.play("down")


func _on_timer_timeout():
	shoot()


func shoot():
	var b = Bullet.instantiate()
	
	# set the bullet transform to the muzzle transform (relative to the player)
	b.transform = $Muzzle.transform
	
	# move the position up slightly so that the bullet comes out of the werewolve's mouth
	b.position.y -= 20
	
	# rotate the bullet so that it is facing forward when shot
	b.rotation_degrees = bullet_rotation_degrees
	
	add_child(b)	
