extends Camera2D


@onready var world_boundary = $"../../WorldBoundaries/CollisionShape2D"

var boundary_position_y = null


func _ready() -> void:
	boundary_position_y = world_boundary.global_position.y

# TODO: use tilemap boundaries to make a better version of this
func _process(delta: float) -> void:
	if global_position.y < boundary_position_y:
		global_position.y = boundary_position_y - 200
