extends StaticBody3D

func effect() -> void:
	GameManager.player.attract_xp_orbs = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		effect()
		queue_free()

func _on_tree_exited() -> void:
	GameManager.player.attract_xp_orbs = false
