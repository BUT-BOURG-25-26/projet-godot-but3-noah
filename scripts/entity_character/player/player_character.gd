extends Node3D

class_name CharacterPlayer

@export var arme_scene: PackedScene
@export var bullet_scene: PackedScene
@export var shoot_vfx_scene: PackedScene

@onready var animations_tree : AnimationTree = $AnimationTree
@onready var weapon_socket : Marker3D = $"character-m/root/torso/arm-right/weapon_socket"

var arme: Pistol

func _ready() -> void:
	var right_arm : Node3D = get_node("character-m/root/torso/arm-right")
	weapon_socket = right_arm.get_node("weapon_socket")
	
	arme = arme_scene.instantiate()
	weapon_socket.add_child(arme)
	arme.global_position = weapon_socket.global_position

func attack(attack_damage, target) -> void:
	var shoot_vfx : VFX = shoot_vfx_scene.instantiate()
	add_child(shoot_vfx)
	shoot_vfx.global_position = arme.output.global_position
	shoot_vfx.emit()
	
	var bullet : Bullet = bullet_scene.instantiate()
	bullet.target = target
	bullet.damage = attack_damage
	bullet.pos = arme.output.global_position
	get_parent().get_parent().add_child(bullet)
	bullet.global_position = arme.global_position
	bullet.scale = Vector3(5, 5, 5)

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die" :
		Engine.time_scale = 0.0
