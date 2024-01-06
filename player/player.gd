extends CharacterBody2D

@export var health = 100
@export var max_health = 100
@export var speed = 400
@export var Bullet : PackedScene

# XP System
@export var level = 1
var experience = 0
var experience_total = 0
var experience_to_level = get_required_experience_to_level(level + 1)

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

func get_required_experience_to_level(newlevel: int):
	return round(pow(newlevel, 1.8) + newlevel * 4)

func gain_experience(amount: int):
	experience += amount
	experience_total += amount
	while experience >= experience_to_level:
		experience -= experience_to_level
		level_up()

func level_up():
	level += 1
	experience_to_level = get_required_experience_to_level(level + 1)
	print("Level Up! Level: ", level)
	# increase the player's speed by 10%
	speed *= 1.1
	max_health *= 1.1
	health = max_health


