extends Control

class_name EnemiesCount

@onready var enemies_alived_label : Label = $enemies_alived
@onready var enemies_killed_label: Label = $enemies_killed

func update() -> void:
	enemies_alived_label.text = "Enemies alived : " + str(GameManager.enemies_alived)
	enemies_killed_label.text = "Enemies killed : " + str(GameManager.enemies_killed)
