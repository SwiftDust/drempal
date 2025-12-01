class_name Asteroid extends RigidBody2D


@export var velocity: Vector2 

@onready var freeing_timer = $FreeingTimer
@onready var sprite_2d = $Sprite2D
@onready var asteroid_images = [preload("res://Entities/Asteroid/asteroid1.png"), preload("res://Entities/Asteroid/asteroid2.png")]
@onready var hit_images = [preload("res://Entities/Asteroid/hit1.png"), preload("res://Entities/Asteroid/hit2.png")]


func _ready() -> void:
	var image = asteroid_images.pick_random()
	sprite_2d.texture = image


func _physics_process(delta: float) -> void:
	var bounce = move_and_collide(velocity * delta)
	if bounce:
		velocity = velocity.bounce(bounce.get_normal()) 


func _on_body_entered(body: Node) -> void:
	var image = hit_images.pick_random()
	sprite_2d.texture = image
	
	if body is Shield:
		body.take_damage()
		queue_free()
		return
	elif body is Player:
		body.take_live()
		return
	
	if body is StaticBody2D:
		freeing_timer.start()


func _on_freeing_timer_timeout() -> void:
	queue_free()
