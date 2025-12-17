extends Control

class_name ScoreUI

@onready var score: Label = $score

func update() -> void:
	score.text = "Score : " + str(GameManager.score)
