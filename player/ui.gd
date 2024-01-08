extends CanvasLayer
class_name UI

@onready var experience_bar = %ExperienceBar

func _ready():
	_update_experience_bar(0, 100)

func _update_experience_bar(experience, experience_to_next_level):
	experience_bar.value = experience
	experience_bar.max_value = experience_to_next_level
