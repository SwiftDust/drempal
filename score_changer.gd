extends Node

signal score_changed(score, highscore)

var score := 0
var highscore := 0

func set_score(value: int):
	score = value
	if score > highscore:
		highscore = score

	emit_signal("score_changed", score, highscore)
