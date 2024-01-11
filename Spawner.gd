extends Node

var snake = preload("res://enemies/snake/Snake.tscn")
@onready var player = $"../Player";

@export var spawn_location: PathFollow2D 

# Called when the node enters the scene tree for the first time.
func _ready():
	$SnakeTimer.start()


func _on_snake_timer_timeout():
	var newSnake = snake.instantiate()
	spawn_enemy_on_path(newSnake)


func spawn_enemy_on_path(enemy: Enemy):
	spawn_location.progress_ratio = randf()
	enemy.position = spawn_location.position

	add_child(enemy)
	
