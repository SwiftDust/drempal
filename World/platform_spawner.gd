class_name PlatformSpawner extends Node2D


@export var platform_scene: PackedScene

@onready var camera_2d = $"../Player/Camera2D"
@onready var player = $"../Player"
@onready var player_collision_shape_node = player.get_node("CollisionShape2D")
@onready var player_collision_shape = player_collision_shape_node.shape

var y_pos := 0


func spawn_platforms(amount: int) -> void:
	var camera_size = get_viewport_rect().size * camera_2d.zoom
	var camera_rect = Rect2(camera_2d.get_screen_center_position() - camera_size / 2, camera_size)
	var height_addition = 5
	for i in amount:
		var height = player_collision_shape.size.y * player_collision_shape_node.global_scale.y * height_addition
		y_pos = camera_rect.end.y - height
		var platform = platform_scene.instantiate()
		platform.position.y = y_pos
		height_addition += 3
		add_child(platform)


func _on_game_manager_game_started() -> void:
	spawn_platforms(4)
