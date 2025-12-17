extends Control

class_name LevelUpCard

@onready var rarete_label: Label = $rarete_label
@onready var stat_label: Label = $stat_label
@onready var value_label: Label = $value_label
@onready var button: Button = $Button

@onready var color_rect : ColorRect = $ColorRect

@export var value : float
@export var stat : String
@export var rarete : String

func _ready() -> void:
	var color : Color
	match rarete:
				"common":
					color = Color(0.2, 0.2, 0.2, 0.8)
				"uncommon":
					color = Color(0, 0.9, 0, 0.8)
				"rare":
					color = Color(0, 0, 0.9, 0.8)
				"epic":
					color = Color(0.5, 0, 0.5, 0.8)
	
	color_rect.color = color
	rarete_label.text = rarete
	stat_label.text = stat.to_upper()
	
	match stat:
		"damage":
			match rarete:
				"common":
					value = 3.0
				"uncommon":
					value = 6.0
				"rare":
					value = 9.0
				"epic":
					value = 12.0
		"speed":
			match rarete:
				"common":
					value = 0.5
				"uncommon":
					value = 1.0
				"rare":
					value = 1.5
				"epic":
					value = 2.0
		"attack speed":
			match rarete:
				"common":
					value = 0.3
				"uncommon":
					value = 0.6
				"rare":
					value = 0.9
				"epic":
					value = 1.2
		"range":
			match rarete:
				"common":
					value = 2.0
				"uncommon":
					value = 4.0
				"rare":
					value = 6.0
				"epic":
					value = 8.0
		"health":
			match rarete:
				"common":
					value = 3.0
				"uncommon":
					value = 6.0
				"rare":
					value = 9.0
				"epic":
					value = 12.0
	
	value_label.text = str(value)
	button.pressed.connect(choose)

func choose() -> void:
	match stat:
		"damage":
			GameManager.player.damage+=value
		"speed":
			GameManager.player.speed+=value
		"attack speed":
			GameManager.player.change_attack_speed(value)
		"range":
			GameManager.player.change_range(value)
		"health":
			GameManager.player.max_health+=value
			GameManager.player.health+=value
			GameManager.player.health_bar.init(GameManager.player.max_health)
			GameManager.player.health_bar.update(GameManager.player.health)
	get_parent().visible = false
	for i in range(get_parent().get_children().size()):
		get_parent().get_child(i).queue_free()
	Engine.time_scale = 1.0
