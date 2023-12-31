extends Node

var snake = preload("res://enemies/snake/Snake.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$SnakeTimer.start()


func _on_snake_timer_timeout():
	var newSnake = snake.instantiate()
	add_child(newSnake)

