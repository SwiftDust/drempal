extends Node2D
 
 
@export var camera_velocity: Vector2 = Vector2(0, 0);
@export var camera_velocity_top: Vector2 = Vector2(0, 0)

@onready var bottom_layer = $BottomLayer
@onready var top_layer = $TopLayer
 
 
func _process(delta: float) -> void:
	var new_offset: Vector2 = bottom_layer.get_scroll_offset() + camera_velocity * delta
	var new_offset_top: Vector2 = top_layer.get_scroll_offset() + camera_velocity * delta

	bottom_layer.set_scroll_offset(new_offset)
	top_layer.set_scroll_offset(new_offset)
