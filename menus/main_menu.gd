extends MarginContainer

func _ready():
	$MainMenuAnimation.play("menu_display_animation")
	$MenuMusicAnimation.play("music_animation")

func _process(delta):
	if Input.is_action_pressed("menu"): # skip to the end of the animation
		$MainMenuAnimation.advance(10)
		$MenuMusicAnimation.advance(4)

func _on_how_to_play_button_pressed():
	pass # Replace with function body.
	#TODO: Make the "How To Play" section visible (also todo: make these nodes)

func _on_quit_button_pressed():
	get_tree().quit()

func _on_begin_button_pressed():
	get_tree().change_scene_to_file("res://test_level.tscn")
