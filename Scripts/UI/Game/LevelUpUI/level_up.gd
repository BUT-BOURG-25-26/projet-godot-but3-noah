extends Control

class_name LevelUpUI

@export var level_up_card_scene : PackedScene

func cards_roll() -> void:
	for i in range(3):
		var luck : int = int(randf_range(1, 101))
		var card : LevelUpCard = level_up_card_scene.instantiate()
		if luck>0 && luck<=40:
			card.rarete = "common"
		if luck>40 && luck<=70:
			card.rarete = "uncommon"
		if luck>70 && luck<=90:
			card.rarete = "rare"
		if luck>90 && luck<=100:
			card.rarete = "epic"
		luck = int(randf_range(1, 6))
		match luck:
			1:
				card.stat = "damage"
			2:
				card.stat = "speed"
			3:
				card.stat = "attack speed"
			4:
				card.stat = "range"
			5:
				card.stat = "health"
		add_child(card)
		var espace = (GameManager.screen_size.x-3*card.size.x)/4
		card.position = Vector2((i+1)*espace+i*card.size.x, (GameManager.screen_size.y/2)-(GameManager.screen_size.y/4))
