class_name Drab extends Area2D


@export var INITIAL_MOVING_SPEED: int = 175
@onready var player_node = $"../Player"


var moving_speed := INITIAL_MOVING_SPEED

func _ready() -> void:
	player_node.next_wave_started.connect(_on_player_next_wave_started)


func _process(delta: float) -> void:
	position.y -= delta * INITIAL_MOVING_SPEED


func _on_player_next_wave_started() -> void:
	moving_speed *= 1.1


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
