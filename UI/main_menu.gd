class_name MainMenu extends Control


@export var game_scene: PackedScene
@export var options_scene: PackedScene
@export var credits_scene: PackedScene
@export var transition_screen: CanvasLayer

@onready var credits = $Credits
@onready var score_node = $Score


func _ready() -> void:
	ScoreChanger.score_changed.connect(_on_score_changed)
	GlobalAudioStreamPlayer.play_gameloop_music()
	_on_score_changed(ScoreChanger.score, ScoreChanger.highscore)


func _on_start_button_pressed() -> void:
	transition_screen.transition()
	if transition_screen.transition_finished:
		get_tree().change_scene_to_packed(game_scene)


func _on_options_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	credits.visible = true


func _on_credits_close_button_pressed() -> void:
	credits.visible = false


func _on_score_changed(score: int, highscore: int) -> void:
	score_node.text = "Score: " + str(score) + " - High Score: " + str(highscore)
