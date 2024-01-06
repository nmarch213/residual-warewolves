extends Node2D

@onready var _xp = get_node("Ui/Xp")
@onready var _player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	_xp.update_xp(_player.level, _player.experience, _player.experience_to_level)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
