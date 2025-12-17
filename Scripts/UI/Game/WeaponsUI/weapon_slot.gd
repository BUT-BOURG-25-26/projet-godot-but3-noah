extends Node3D

class_name WeaponSlot

var weapon : Weapons
var weapon_scene : PackedScene

func init(weapon_name : String) -> void:
	weapon_name = weapon_name.replace("-", "_")
	weapon_scene = load("res://Scenes/Weapons/WeaponsScenes/" + weapon_name + ".tscn")
	weapon = weapon_scene.instantiate()
	add_child(weapon)
	weapon.global_position = global_position
	weapon.scale = Vector3(1.5, 1.5, 1.5)
	weapon.rotate_x(-0.6)

func _physics_process(delta: float) -> void:
	weapon.rotate_y(-0.02)

func _on_area_3d_body_entered(body: Node3D) -> void:
	GameManager.change_weapon(weapon_scene)
