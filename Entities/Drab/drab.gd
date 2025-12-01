class_name Drab extends Area2D


@export var INITIAL_MOVING_SPEED: int = 175
@onready var player_node = $"../Player"


var moving_speed := INITIAL_MOVING_SPEED
var speed := 160.0
var offset := 20
var direction := 1
var start_x := 0.0



func _ready() -> void:
	player_node.next_wave_started.connect(_on_player_next_wave_started)
	start_x = position.x



func _process(delta: float) -> void:
	position.y -= delta * INITIAL_MOVING_SPEED
	position.x += speed * direction * delta
	
	if abs(position.x - start_x) >= offset:
		direction *= -1


func _on_player_next_wave_started(wave) -> void:
	moving_speed *= 1.1


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
