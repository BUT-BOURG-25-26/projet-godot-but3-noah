extends StaticBody3D

func effect() -> void:
	if !GameManager.player.attack_speed_power_up_active:
		GameManager.player.attack_speed_change(1)
	GameManager.player.power_up_active = true
	GameManager.player.attack_speed_power_up_active = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		effect()
		queue_free()
