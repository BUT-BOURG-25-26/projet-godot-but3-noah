extends Control

class_name HealthBar

@onready var health_bar : ProgressBar = $ProgressBar

func init(max_health) -> void:
	health_bar.max_value = max_health

func update(health) -> void:
	health_bar.value = health
