class_name Enemy extends CharacterBody2D

var FCT_scene = preload("res://enemies/FCT/FCT.tscn")

@export var run_speed = 100
@export var health = 100

const VECTOR_TO_DIRECTION_DICT = {
	Vector2(1, 0): 'right',
	Vector2(-1, 0): 'left',
	Vector2(0, -1): 'up',
	Vector2(0, 1): 'down',
}


var player = null

func _physics_process(delta):
	if !player:
		player = get_node("/root/TestLevel/Player")
	else:
		velocity = position.direction_to(player.position) * run_speed
		move_and_collide(velocity * delta)
		handle_animation()

func take_damage(damage_amount):
	health -= damage_amount
	show_damage(damage_amount)

	if health <= 0:
		# added to show FCT and death animation
		await get_tree().create_timer(1).timeout
		queue_free()


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


func show_damage(damage_amount):
	# this expects you to add a Marker2d to every enemy named FCT to show the dmg
	if !$FCT:
		return
	var fct = FCT_scene.instantiate()
	$FCT.add_child(fct)
	fct.show_dmg(damage_amount, fct)
