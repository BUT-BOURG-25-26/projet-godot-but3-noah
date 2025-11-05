extends Control

class_name StartMenu

@onready var start_button : Button = $start_button
@onready var quit_button : Button = $quit_button

func _ready() -> void:
	start_button.pressed.connect(start)
	quit_button.pressed.connect(quit)
	
func start():
	GameManager.weapon_choice()

func quit():
	GameManager.quit()
