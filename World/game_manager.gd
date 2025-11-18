class_name GameManager extends Node


@export var asteroid_scene: PackedScene
@export var shield_scene: PackedScene
@onready var asteroid_timer = $AsteroidTimer


func _ready() -> void:
	var shield = shield_scene.instantiate()
	add_child(shield)
	
	asteroid_timer.start()

func _on_asteroid_timer_timeout() -> void:
	var asteroid = asteroid_scene.instantiate()
	
	var asteroid_spawn_location = $AsteroidPath/AsteroidSpawnLocation
	asteroid_spawn_location.progress_ratio = randf()
	
	asteroid.position = asteroid_spawn_location.position
	
	# quick note to myself in case I forget: 
	# this means a full 360 degrees circle as 2*pi is 360 degrees
	var random_angle = randf_range(0, 2 * PI)
	var random_speed = randf_range(50, 150) 
	
	var direction = Vector2(cos(random_angle), sin(random_angle)) 
	asteroid.velocity = direction * random_speed 
	
	add_child(asteroid)
