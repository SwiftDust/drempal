class_name Asteroid extends RigidBody2D


@export var velocity: Vector2 

@onready var freeing_timer = $FreeingTimer


func _physics_process(delta: float) -> void:
	var bounce = move_and_collide(velocity * delta)
	if bounce:
		velocity = velocity.bounce(bounce.get_normal()) 


func _on_freeing_timer_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node) -> void:	
	if body is StaticBody2D:
		freeing_timer.start()
	
	# TODO: if body is area2d, then bounce, wait few seconds and queue_free()
	# if it is player, then player should take live
