class_name Shield extends StaticBody2D


@export var SPEED = 5

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var player_node = $"../Player"

var shield_visible = true
var damage_taken := 0
var max_damage := 10
var original_scale := self.scale
 

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
		
func take_damage():
	## TODO: show the cracks in the shield, for now I'm just going to let it shrink by .99
	# the max damage it can take is 10, after that it'll disappear completely 
	scale *= 0.99
	damage_taken += 1
	print(damage_taken)
	
	if damage_taken > max_damage:
		collision_shape.set_deferred("disabled", true)
		sprite.hide()


func _ready() -> void:
	player_node.player_died.connect(_on_player_died)
	player_node.next_wave_started.connect(_on_player_next_wave_started)


func _physics_process(delta: float) -> void:
	position = player_node.position
	
	if Input.is_action_just_pressed("toggle_shield"):
		shield_visible = false if shield_visible == true else true 
	
	if shield_visible:
		handle_movement(delta)
		sprite.show()
		collision_shape.set_deferred("disabled", false)
	else:
		sprite.hide()
		collision_shape.set_deferred("disabled", true)

func _on_player_died():
	queue_free()
	
func _on_player_next_wave_started():
	collision_shape.set_deferred("disabled", false)
	sprite.show()
	scale = original_scale
	damage_taken = 0
	max_damage *= 1.5
