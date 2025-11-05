extends Control

class_name GameOver

@onready var rejouer_bouton : Button = $rejouer
@onready var quitter_bouton : Button = $quitter
@onready var time_survived_label : Label = $time_survived

func _ready() -> void:
	rejouer_bouton.pressed.connect(_rejouer)
	quitter_bouton.pressed.connect(_quitter)
	
func _rejouer():
	GameManager.weapon_choice()

func _quitter():
	GameManager.back_menu_start()
