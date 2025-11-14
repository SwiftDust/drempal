class_name Shield extends StaticBody2D


@export var SPEED = 5
@export var player: Player

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

var shield_visible = true;

func handle_movement(delta) -> void:
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()
	
	var target_angle = direction.angle()
	var current_angle = rotation
	
	var angle_diff = angle_difference(current_angle, target_angle)
	
	rotation += sign(angle_diff) * min(abs(angle_diff), SPEED * delta)
	
	if rotation > deg_to_rad(30):
		rotation = deg_to_rad(30)
	if rotation < deg_to_rad(-30):
		rotation = deg_to_rad(-30)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("toggle_shield"):
		shield_visible = false if shield_visible == true else true 
	
	if shield_visible:
		handle_movement(delta)
		sprite.show()
		collision_shape.set_deferred("disabled", false)
	else:
		sprite.hide()
		collision_shape.set_deferred("disabled", true)
