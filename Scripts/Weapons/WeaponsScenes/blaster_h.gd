extends Weapons

func _ready() -> void:
	damage_ratio = 1
	attack_speed_ratio = 0.65
	range_ratio = 1
	bullet_speed = 20

func shoot(damage) -> void:
	for i in range(5):
		var bullet : Bullet = bullet_scene.instantiate()
		bullet.target = GameManager.player.nearest_enemy.target.global_position
		bullet.speed = bullet_speed
		bullet.damage = damage
		bullet.pos = output.global_position
		bullet.angle_x = randf_range(-20, 20)
		bullet.angle_y = randf_range(-20, 20)
		bullet.angle_z = randf_range(-20, 20)
		GameManager.original_node.add_child(bullet)
		bullet.global_position = output.global_position
