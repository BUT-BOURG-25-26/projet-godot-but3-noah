extends Monsters

class_name BaseMushroom

func _ready() -> void:
	health = 10
	damage = 3
	speed = 2
	range = 1.5
	xp_amount = 15
	score = 25
	player = GameManager.player

func _physics_process(delta: float) -> void:
	if !is_dead :
		if !player.is_dead:
			enemy_movement()
			look_at_player()
			collision()
			death()
		else:
			dance()
