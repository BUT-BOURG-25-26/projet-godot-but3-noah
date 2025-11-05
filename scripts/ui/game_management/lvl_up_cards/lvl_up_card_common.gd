extends LvlUpCard

@onready var titre_label : Label = $titre
@onready var min_value_label : Label = $ValeurMin
@onready var max_value_label : Label = $ValeurMax
@onready var value_label : Label = $Valeur
@onready var button : Button = $Button

func _ready() -> void:
	rarity = "common"
	
	match type:
		"damage":
			min_value = 2
			max_value = 4
		"speed":
			min_value = 0.5
			max_value = 1
		"health":
			min_value = 3
			max_value = 7
		"attack speed":
			min_value = 0.3
			max_value = 0.5
		"range":
			min_value = 2
			max_value = 4
	value = snapped(randf_range(min_value, max_value), 0.1)
	titre_label.text = type
	min_value_label.text = "Min : "+str(min_value)
	max_value_label.text = "Max : "+str(max_value)
	value_label.text = "Value : "+str(value)
	
	button.pressed.connect(choose)

func choose() -> void:
	match type:
		"damage":
			GameManager.player.attack_damage+=value
		"speed":
			GameManager.player.movement_speed+=value
		"health":
			GameManager.player.health+=value
			GameManager.player.max_health+=value
		"attack speed":
			GameManager.player.attack_speed_change(value)
		"range":
			GameManager.player.range_change(value)
	GameManager.stats_panel_ui.update()
	get_parent().visible = false
	Engine.time_scale = 1.0
