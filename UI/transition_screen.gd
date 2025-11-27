extends CanvasLayer


@export var color_rect: ColorRect
@export var animation_player: AnimationPlayer

signal transition_finished

func _ready() -> void:
	print(color_rect, animation_player)


func transition() -> void:
	animation_player.play("fade_to_black")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		transition_finished.emit()
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
