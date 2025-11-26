class_name HeadsUpDisplay extends CanvasLayer


@onready var score_label = $"MarginContainer/ScoreLiveContainer/ScoreLabel"
@onready var multiplier_label = $"MarginContainer/ScoreLiveContainer/MultiplierLabel"
@onready var waves_label = $"MarginContainer/ScoreLiveContainer/WavesLabel"
@onready var lives = [
	$"MarginContainer/ScoreLiveContainer/VBoxContainer/Live1",
	$"MarginContainer/ScoreLiveContainer/VBoxContainer/Live2",
	$"MarginContainer/ScoreLiveContainer/VBoxContainer/Live3"
]


func update_score(score, multiplier, wave):
	score_label.text = "score: " + str(score)
	multiplier_label.text = "multiplier: " + str(multiplier)
	waves_label.text = "wave: " + str(wave)


# dude i love these for loops, even though they seem so simple lmao
func remove_live():
	for live in lives:
		if live.visible == true:
			live.visible = false
			return
