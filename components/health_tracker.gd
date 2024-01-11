extends Node2D
class_name HealthTracker

@export var hit_sfx: AudioStreamPlayer
@export var max_hp := 100.0
var current_hp : float

signal death
signal damage_taken(damage)


# Called when the node enters the scene tree for the first time.
func _ready():
	current_hp = max_hp

func take_damage(damage):
	print("in take damage")
	if(hit_sfx):
		hit_sfx.play()
	if $HitTimer.time_left == 0:
		$HitTimer.start()
		
	current_hp -= damage
	damage_taken.emit(damage)
	if current_hp <= 0:
		death.emit()
	if get_parent().has_method('show_damage'):
		get_parent().show_damage(damage)

func heal(amount):
	current_hp = min(current_hp + amount, max_hp)

func heal_full():
	current_hp = max_hp
