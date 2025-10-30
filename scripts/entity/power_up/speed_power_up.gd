extends StaticBody3D

func effect() -> void:
	if !GameManager.player.speed_power_up_active:
		GameManager.player.movement_speed+=3
	GameManager.player.power_up_active = true
	GameManager.player.speed_power_up_active = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		effect()
		queue_free()
