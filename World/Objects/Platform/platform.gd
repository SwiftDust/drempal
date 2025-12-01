class_name Platform extends StaticBody2D


@onready var sprites := [preload("res://World/Objects/Platform/platform1.png"), preload("res://World/Objects/Platform/platform2.png")]
@onready var sprite_2d = $Sprite2D


func _ready() -> void:
	var sprite = sprites.pick_random()
	sprite_2d.texture = sprite
