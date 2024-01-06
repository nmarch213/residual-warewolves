extends Node2D
class_name HealthTracker

@export var MAX_HP := 100.0
var current_hp : float

signal death
signal damage_taken(damage)


# Called when the node enters the scene tree for the first time.
func _ready():
	current_hp = MAX_HP

func take_damage(damage):
	current_hp -= damage
	damage_taken.emit(damage)
	if current_hp <= 0:
		death.emit()
	if get_parent().has_method('show_damage'):
		get_parent().show_damage(damage)

func heal(amount):
	current_hp = min(current_hp + amount, MAX_HP)
