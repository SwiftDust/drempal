class_name Player extends CharacterBody2D


@onready var heads_up_display = $"../HUD"

@export var FRICTION = 2000.0
@export var SPEED = 1500.0
@export var STEP_DISTANCE = 250.0
@export var JUMP_VELOCITY = -600.0
@export var MAX_JUMPS = 2
# coyote time is the time the user has to react if they fall off the platform
@export var COYOTE_TIME_WINDOW = 0.2


signal player_died
signal player_ate_food
signal next_wave_started

enum States {IDLE, MOVING, JUMPING, FALLING}
var state: States = States.IDLE: set = set_state

var jump_count := 0
var time_in_air := 0.0
var direction_sign := 0
var target_distance := 0.0
var lives := 3
var score := 20.0
var score_multiplier := 1.0
var wave := 1
var next_wave_at := 25
var original_scale := Vector2()


func _ready() -> void:
	original_scale = scale


func set_state(new_state: States) -> void:
	state = new_state
	
	if state == States.MOVING:
		target_distance = STEP_DISTANCE
	
	## TODO: add animations for the state


func increment_score_multiplier():
	var tween = create_tween()
	# smooth sine wave transition with a slight scale up
	tween.tween_property(self, "scale", scale * 1.1, 0.15)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)
	player_ate_food.emit()
	score_multiplier += 1.5

func take_live():
	lives -= 1
	heads_up_display.remove_live()
	if lives == 0:
		die()


func die():
	## TODO: add animations for die
	player_died.emit()
	get_tree().call_deferred("change_scene_to_file", "res://UI/main_menu.tscn")
	queue_free() # just a placeholder so we at least have something visual



func _physics_process(delta: float) -> void:
	print("adfe")
	var is_initiating_jump := Input.is_action_just_pressed("jump") and (jump_count == MAX_JUMPS - 1 or (is_on_floor() or time_in_air < COYOTE_TIME_WINDOW))
	var is_initiating_burst = Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")
	
	if is_initiating_jump:
		state = States.JUMPING
	elif state == States.JUMPING and velocity.y > 0.0:
		state = States.FALLING
	elif is_initiating_burst:
		state = States.MOVING
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		time_in_air += delta
	else:
		time_in_air = 0
		jump_count = 0
		
	if is_initiating_jump:
		jump_count += 1
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("move_left", "move_right")
	direction_sign = sign(direction)
	
	if is_initiating_burst:
		velocity.x = direction_sign * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		
	if target_distance > 0:
		target_distance -= abs(velocity.x * delta)
	if target_distance <= 0:
		velocity.x = 0
		
	if score > next_wave_at:
		wave += 1
		next_wave_at *= 1.5
		scale = original_scale
		next_wave_started.emit()
	
	move_and_slide()
	score += get_process_delta_time() * score_multiplier
	heads_up_display.update_score(int(score), score_multiplier, wave)
