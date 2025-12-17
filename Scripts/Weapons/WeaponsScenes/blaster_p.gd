extends Weapons

@onready var output1: Marker3D = $output1
@onready var output2: Marker3D = $output2

func _ready() -> void:
	damage_ratio = 0.15
	attack_speed_ratio = 10
	range_ratio = 1.1
	bullet_speed = 20

func shoot(damage) -> void:
	var bullet1 : Bullet = bullet_scene.instantiate()
	bullet1.target = GameManager.player.nearest_enemy.target.global_position
	bullet1.speed = bullet_speed
	bullet1.damage = damage
	bullet1.pos = output1.global_position
	GameManager.original_node.add_child(bullet1)
	bullet1.global_position = output1.global_position
	
	var bullet2 : Bullet = bullet_scene.instantiate()
	bullet2.target = GameManager.player.nearest_enemy.target.global_position
	bullet2.speed = bullet_speed
	bullet2.damage = damage
	bullet2.pos = output2.global_position
	GameManager.original_node.add_child(bullet2)
	bullet2.global_position = output2.global_position
