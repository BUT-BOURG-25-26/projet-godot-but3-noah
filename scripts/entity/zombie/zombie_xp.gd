extends StaticBody3D

@export var xp_amount : int
@export var go_to_player : bool = false

func _ready() -> void:
	xp_amount = 10

func _physics_process(delta: float) -> void:
	if GameManager.player.attract_xp_orbs:
		go_to_player = true
	if go_to_player:
		var direction : Vector3
		direction.x = GameManager.player.global_position.x - global_position.x
		direction.z = GameManager.player.global_position.z - global_position.z
		direction = direction.normalized()
		translate(direction * delta * 10)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		var player : Player = GameManager.player
		player.gain_xp(xp_amount)
		queue_free()
