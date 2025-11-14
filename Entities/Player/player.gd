class_name Player extends CharacterBody2D


@export var FRICTION = 2000.0
@export var SPEED = 1500.0
@export var STEP_DISTANCE = 250.0
@export var JUMP_VELOCITY = -600.0
@export var MAX_JUMPS = 2

enum States {IDLE, BURSTING, JUMPING, FALLING}
var state = States.IDLE

var count := 0
var direction_sign := 0
var target_distance := 0.0


func _physics_process(delta: float) -> void:	
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		count = 0
		
	if  Input.is_action_just_pressed("jump") and count < MAX_JUMPS:
		count += 1
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
