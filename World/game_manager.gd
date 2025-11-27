class_name GameManager extends Node2D


signal game_started


@export var asteroid_scene: PackedScene
@export var shield_scene: PackedScene
@onready var asteroid_timer = $AsteroidTimer
@onready var camera_2d = $"Player/Camera2D"
@onready var next_wave = $"Next Wave"

var shield: Node


func _ready() -> void:
	shield = shield_scene.instantiate()
	add_child(shield)
	
	asteroid_timer.start()
	game_started.emit()

func _on_asteroid_timer_timeout() -> void:
	var asteroid = asteroid_scene.instantiate()
	var camera_size: Variant
	var camera_rect: Rect2
	
	if camera_2d:
		camera_size = get_viewport_rect().size * camera_2d.zoom
		camera_rect = Rect2(camera_2d.get_screen_center_position() - camera_size / 2, camera_size)
	var asteroid_spawn_location = {
		"x": randf_range(0.0, camera_rect.end.x),
		"y": camera_rect.position.y
	}
	
	asteroid.position = Vector2(asteroid_spawn_location.x, asteroid_spawn_location.y)
	
	# quick note to myself in case I forget: 
	# this means a full 360 degrees circle as 2*pi is 360 degrees
	var random_angle = randf_range(0, 2 * PI)
	var random_speed = randf_range(50, 150) 
	
	var direction = Vector2(cos(random_angle), sin(random_angle)) 
	asteroid.velocity = direction * random_speed 
	
	add_child(asteroid)


func _on_player_player_ate_food() -> void:
	var tween = create_tween()
	if shield:
		tween.tween_property(shield, "scale", scale * 1.1, 0.15)\
			.set_trans(Tween.TRANS_SINE)\
			.set_ease(Tween.EASE_OUT)


func _on_player_next_wave_started() -> void:
	asteroid_timer.wait_time *= 0.9
	next_wave.visible = true
