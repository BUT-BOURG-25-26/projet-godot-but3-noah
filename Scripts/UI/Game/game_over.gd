extends Control

class_name GameOver

@onready var time_played_label : Label = $time_played
@onready var restart_btn : Button = $restart
@onready var quit_btn : Button = $quit

func _ready() -> void:
	restart_btn.pressed.connect(_restart)
	quit_btn.pressed.connect(_quit)

func init_time_played(time) -> void:
	time_played_label.text = "Time played : " + str(time) + " seconds"

func _quit() -> void:
	GameManager.quit()

func _restart() -> void:
	GameManager.restart()
