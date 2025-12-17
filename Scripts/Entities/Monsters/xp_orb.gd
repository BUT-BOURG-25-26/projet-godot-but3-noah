extends Area3D

class_name XpOrb

@export var amount : float
@export var go_to_player : bool = false

@onready var xp_mesh_instance : MeshInstance3D = $MeshInstance3D

func _ready() -> void:
	var base_material : Material = xp_mesh_instance.mesh.surface_get_material(0)
	var unique_material : Material = base_material.duplicate()
	xp_mesh_instance.set_surface_override_material(0, unique_material)
	var new_color : Color
	match amount:
		15.0:
			new_color = Color(0.0, 0.5, 0.0, 1.0)
			unique_material.set("albedo_color", new_color)
		30.0:
			new_color = Color(1, 0.0, 0.0, 1.0)
			unique_material.set("albedo_color", new_color)

func _physics_process(delta: float) -> void:
	if GameManager.player.attract_xp_orbs:
		go_to_player = true
	if go_to_player:
		var direction : Vector3
		direction.x = GameManager.player.global_position.x - global_position.x
		direction.z = GameManager.player.global_position.z - global_position.z
		direction = direction.normalized()
		translate(direction * delta * 10)

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		GameManager.player.xp += amount
		GameManager.xp_bar.update(GameManager.player.xp*100/GameManager.player.xp_floor_amount)
		queue_free()
