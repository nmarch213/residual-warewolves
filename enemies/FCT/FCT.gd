extends Marker2D
class_name FCT


func show_dmg(number, fct: FCT ):
	$CombatText.text = str(number)
	var tween = get_tree().create_tween()
	tween.tween_property(fct, "position", fct.position + _get_direction(), 0.75)

func _get_direction():
	return Vector2(randf_range(-1, 1), -randf()) * 16
