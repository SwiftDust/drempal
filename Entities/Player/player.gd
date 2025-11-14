class_name Player extends CharacterBody2D


@export var FRICTION = 2000.0
@export var SPEED = 1500.0
@export var STEP_DISTANCE = 250.0
@export var JUMP_VELOCITY = -600.0
@export var MAX_JUMPS = 2
# Coyote time is the time the user has to react if they fall off the platform
@export var COYOTE_TIME_WINDOW = 0.1

var jump_count := 0
var time_in_air := 0.0
var direction_sign := 0
var target_distance := 0.0


func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity += get_gravity() * delta
		time_in_air += delta
	else:
		time_in_air = 0
		jump_count = 0
		
	#if Input.is_action_just_pressed("jump") and (jump_count == MAX_JUMPS - 1 or (is_on_floor() or time_in_air < COYOTE_TIME_WINDOW)):
	if Input.is_action_just_pressed("jump") and (is_on_floor() or time_in_air < COYOTE_TIME_WINDOW or jump_count < MAX_JUMPS):
		jump_count += 1
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("move_left", "move_right")
	direction_sign = sign(direction)
	
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		velocity.x = direction_sign * SPEED 
		target_distance = STEP_DISTANCE
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	if target_distance > 0:
		target_distance -= abs(velocity.x * delta)
	if target_distance <= 0:
		velocity.x = 0
	
	move_and_slide()
