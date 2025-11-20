class_name PlatformSpawner extends Node2D


@export var platform_scene: PackedScene
@export var food_scene: PackedScene

@onready var camera_2d = $"../Player/Camera2D"
@onready var player = $"../Player"
@onready var player_collision_shape_node = player.get_node("CollisionShape2D")
@onready var player_collision_shape = player_collision_shape_node.shape

var food_spawn_positions := ["left", "center", "right"]


func spawn_platforms(amount: int) -> void:
	var camera_size = get_viewport_rect().size * camera_2d.zoom
	var camera_rect = Rect2(camera_2d.get_screen_center_position() - camera_size / 2, camera_size)
	var height_addition = 5
	var food_spawn_chance = 0.5 
	for i in range(amount):
		var height = player_collision_shape.size.y * player_collision_shape_node.global_scale.y * height_addition
		var platform_position = {
			"x": randf_range(0, camera_rect.end.x),
			"y": camera_rect.end.y - height
		}
		var platform = platform_scene.instantiate()
		
		platform.position = Vector2(platform_position.x, platform_position.y)
		height_addition += 3
		
		add_child(platform)
		
		if randf() < food_spawn_chance:
			var food = food_scene.instantiate()
			var food_location = food_spawn_positions.pick_random()
			var platform_collision_shape = platform.get_node("CollisionShape2D").shape
			var platform_width = platform_collision_shape.extents.x * 2
			var platform_height = platform_collision_shape.extents.y * 2
			var food_position = Vector2()
			var offset: int = 50
			var food_height_above_platform = platform_height / 2 + 30
			
			match food_location:
				"left":
					food_position = Vector2(
						platform_position.x - platform_width / 2 - offset, 
						platform_position.y - food_height_above_platform
					)
				"center":
					food_position = Vector2(
						platform_position.x, 
						platform_position.y - food_height_above_platform
					)
				"right":
					food_position = Vector2(
						platform_position.x + platform_width / 2 + offset, 
						platform_position.y - food_height_above_platform
					)
			food.position = food_position
			add_child(food)


func _on_game_manager_game_started() -> void:
	spawn_platforms(100)
