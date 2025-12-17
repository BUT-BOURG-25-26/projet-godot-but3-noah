extends Control

class_name XpBar

@onready var xp_bar : ProgressBar = $ProgressBar

func update(xp) -> void:
	xp_bar.value = xp
