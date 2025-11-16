class_name GameManager extends Node


@export var asteroid_scene: PackedScene
@onready var asteroid_timer = $AsteroidTimer

var lives := 0


func _ready() -> void:
	asteroid_timer.start()


func _on_asteroid_timer_timeout() -> void:
	var asteroid = asteroid_scene.instantiate()
	
	var asteroid_spawn_location = $AsteroidPath/AsteroidSpawnLocation
	asteroid_spawn_location.progress_ratio = randf()
	
	asteroid.position = asteroid_spawn_location.position
	
	add_child(asteroid)
