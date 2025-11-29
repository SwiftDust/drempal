extends CanvasLayer


@onready var player = $"../Player"
@onready var wave_node = $"Panel/VBoxContainer/Wave"
@onready var spawn_speed_node = $"Panel/VBoxContainer/Asteroid Spawn Speed"
@onready var shield_hp_node = $"Panel/VBoxContainer/New Shield HP"


func update(wave: int, spawn_speed: float, shield_hp: int):
	wave_node.text = "Wave: " + str(wave)
	spawn_speed_node.text = "Asteroid spawn speed: " + str(spawn_speed)
	shield_hp_node.text = "New shield HP: " + str(shield_hp)


func _on_button_pressed() -> void:
	get_tree().paused = false
	visible = false
