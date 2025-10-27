extends StaticBody3D

@export var xp_amount : int

func _ready() -> void:
	xp_amount = 10

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		queue_free()
		var player : Player = get_tree().get_first_node_in_group("player")
		player.gain_xp(xp_amount)
