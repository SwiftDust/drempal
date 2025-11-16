class_name Asteroid extends RigidBody2D

@export var ground: CollisionShape2D


func _on_body_entered(body: Node) -> void:
	pass
	
	# TODO: if body is area2d, then bounce, wait few seconds and queue_free()
	# if it is player, then player should take live
