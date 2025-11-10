extends Control

class_name LevelUpStats

@export var common_card_scene : PackedScene
@export var uncommon_card_scene : PackedScene
@export var rare_card_scene : PackedScene
@export var epic_card_scene : PackedScene

func cards_roll() -> void:
	for i in range(3):
		var luck : int = int(randf_range(1, 101))
		var card : LvlUpCard
		if luck>0 && luck<=40:
			card = common_card_scene.instantiate()
		if luck>40 && luck<=70:
			card = uncommon_card_scene.instantiate()
		if luck>70 && luck<=90:
			card = rare_card_scene.instantiate()
		if luck>90 && luck<=100:
			card = epic_card_scene.instantiate()
		luck = int(randf_range(1, 6))
		match luck:
			1:
				card.type = "damage"
			2:
				card.type = "speed"
			3:
				card.type = "attack speed"
			4:
				card.type = "range"
			5:
				card.type = "health"
		add_child(card)
		var espace = (GameManager.screensize.x-3*card.size.x)/4
		card.position = Vector2((i+1)*espace+i*card.size.x, 228)
	
