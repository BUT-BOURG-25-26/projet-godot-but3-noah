extends Node3D

class_name PowerUp

@onready var power_up_mesh_instance : MeshInstance3D = $WaterBottle_3
@onready var area : Area3D = $Area3D

@export var type : String

func _ready() -> void:
	var power_up_mesh : Mesh = power_up_mesh_instance.mesh
	var power_up_material : Material = power_up_mesh.surface_get_material(2)
	var unique_material : Material = power_up_material.duplicate()
	power_up_mesh_instance.set_surface_override_material(2, unique_material)
	var new_color : Color
	match type:
		"damage":
			new_color = Color(1, 0.0, 0.0, 1.0)
		"attack speed":
			new_color = Color(1, 1, 0.0, 1.0)
		"speed":
			new_color = Color(0.0, 0.0, 1, 1.0)
		"xp":
			new_color = Color(0.0, 1, 0.0, 1.0)
	unique_material.set("albedo_color", new_color)
	rotate_x(-0.6)

func _physics_process(delta: float) -> void:
	rotate_y(-0.02)

func effect() -> void:
	match type:
		"damage":
			if !GameManager.player.damage_power_up_active:
				GameManager.player.damage += 4
				print("Début power up damage : ", GameManager.player.damage)
			GameManager.player.damage_power_up_received = true
		"attack speed":
			if !GameManager.player.attack_speed_power_up_active:
				GameManager.player.change_attack_speed(0.25)
				print("Début power up attack speed : ", GameManager.player.attack_speed)
			GameManager.player.attack_speed_power_up_received = true
		"speed":
			if !GameManager.player.speed_power_up_active:
				GameManager.player.speed += 3
				print("Début power up speed : ", GameManager.player.speed)
			GameManager.player.speed_power_up_received = true
		"xp":
			GameManager.player.attract_xp_orbs = true

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		effect()
		queue_free()

func _on_tree_exiting() -> void:
	GameManager.player.attract_xp_orbs = false
