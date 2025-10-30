extends StaticBody3D

func effect() -> void:
	if !GameManager.player.damage_power_up_active:
		GameManager.player.attack_damage+=10
	GameManager.player.power_up_active = true
	GameManager.player.damage_power_up_active = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		effect()
		queue_free()
