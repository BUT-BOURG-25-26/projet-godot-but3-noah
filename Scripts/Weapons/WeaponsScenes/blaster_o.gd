extends Weapons

@onready var output1: Marker3D = $output1
@onready var output2: Marker3D = $output2
@onready var output3: Marker3D = $output3
@onready var output4: Marker3D = $output4

func _ready() -> void:
	damage_ratio = 1.2
	attack_speed_ratio = 0.5
	range_ratio = 1
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
	
	var bullet3 : Bullet = bullet_scene.instantiate()
	bullet3.target = GameManager.player.nearest_enemy.target.global_position
	bullet3.speed = bullet_speed
	bullet3.damage = damage
	bullet3.pos = output3.global_position
	GameManager.original_node.add_child(bullet3)
	bullet3.global_position = output3.global_position
	
	var bullet4 : Bullet = bullet_scene.instantiate()
	bullet4.target = GameManager.player.nearest_enemy.target.global_position
	bullet4.speed = bullet_speed
	bullet4.damage = damage
	bullet4.pos = output4.global_position
	GameManager.original_node.add_child(bullet4)
	bullet4.global_position = output4.global_position
