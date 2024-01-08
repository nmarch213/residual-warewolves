extends Node2D
class_name Game

@export var player: Player
@export var ui: UI

func _ready():
	if !player.experience_gained.is_connected(ui._update_experience_bar):
		player.experience_gained.connect(ui._update_experience_bar)


