extends Control

class_name ScoreUI

@onready var score_label : Label = $score_label
@onready var enemies_alive_label : Label = $enemies_alive_label

func update() -> void:
	score_label.text = "Enemies killed : "+str(GameManager.kill_count)
	enemies_alive_label.text = "Enemies alive : "+str(GameManager.enemies_alive)
