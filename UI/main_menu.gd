class_name MainMenu extends Control


@export var game_scene: PackedScene
@export var options_scene: PackedScene
@export var credits_scene: PackedScene
@export var transition_screen: CanvasLayer

@onready var credits = $Credits
@onready var score_node = $Score
@onready var hint_node = $Hint


var hints := [
	"if an asteroid touches your shield
	it will immediately disappear!",
	"like most things, your shield
	isn't invincible...",
	"this is your sign to give us 5 stars :)",
	"you should share your high score in the comments!",
	"hello! refresh for some hints
	 (or play a round and come back :))",
	"music is 100% home-made (i'm so sorry for your ears)",
	"no AI was used to create our art™ (cough cough COD)"
]


func _ready() -> void:
	var hint = hints.pick_random()
	hint_node.text = hint
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
	score_node.text = "Score: " + str(score) + " — High Score: " + str(highscore)
