class_name Food extends Area2D


@onready var player = $"../../Player"
@onready var timer = $AnimationTimer
@export var SPEED = 10

var follow_player := false
var timer_started := false


func _process(delta: float) -> void:
	if follow_player:
		if timer_started == false:
			timer.start()
			timer_started = true
		if is_instance_valid(position):
			position = lerp(position, player.position, SPEED * delta)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		follow_player = true


func _on_animation_timer_timeout() -> void:
	player.increment_score_multiplier()
	queue_free()
