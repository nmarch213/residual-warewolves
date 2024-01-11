class_name Enemy extends CharacterBody2D

var FCT_scene = preload("res://enemies/FCT/FCT.tscn")
var XP_Shard_scene = preload("res://items/xp/xp_shard.tscn")

@export var run_speed = 100
@export var dmg = 1

const VECTOR_TO_DIRECTION_DICT = {
	Vector2(1, 0): 'right',
	Vector2(-1, 0): 'left',
	Vector2(0, -1): 'up',
	Vector2(0, 1): 'down',
}

var player: Player
var dmg_body: Player

func _physics_process(delta):
		if !player:
			player = get_tree().get_nodes_in_group("Player")[0]
			return
		velocity = position.direction_to(player.position) * run_speed
		move_and_collide(velocity * delta)
		handle_animation()

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

func _on_health_tracker_damage_taken(amount):
	if !$FCT:
		return
	var fct = FCT_scene.instantiate()
	$FCT.add_child(fct)
	fct.show_dmg(amount, fct)


func _on_health_tracker_death():
	var shard = XP_Shard_scene.instantiate()
	#get_parent().add_child(shard)
	get_parent().call_deferred("add_child", shard)
	shard.position = global_position
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		print("in area entered")
		dmg_body = body
		
func _on_damage_area_2d_body_exited(body):
	if body.is_in_group("Player"):
		dmg_body = null

func _on_damage_timer_timeout():
	if dmg_body:
		print("on timer timeout")
		dmg_body.get_node("HealthTracker").take_damage(dmg)
