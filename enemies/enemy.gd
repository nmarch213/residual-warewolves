class_name Enemy extends CharacterBody2D

@export var run_speed = 100
@export var health = 100

const VECTOR_TO_DIRECTION_DICT = {
	Vector2(1, 0): 'right',
	Vector2(-1, 0): 'left',
	Vector2(0, -1): 'up',
	Vector2(0, 1): 'down',
}

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
	var vec_to_player = player.global_position - global_position
	vec_to_player = vec_to_player.normalized()

	if velocity.x == 0 and velocity.y == 0:
		$Sprite.stop()
	else:
		$Sprite.play(get_facing_direction(vec_to_player))


func get_facing_direction(vec_to_player) -> String:
	var facing_vec = get_facing_vector(vec_to_player)
	return VECTOR_TO_DIRECTION_DICT[facing_vec]


func get_facing_vector(vec_to_player):
	var min_angle = 360
	var facing = Vector2()
	for vec in VECTOR_TO_DIRECTION_DICT.keys():
		var ang = abs(vec_to_player.angle_to(vec))
		if ang < min_angle:
			min_angle = ang
			facing = vec
	return facing


