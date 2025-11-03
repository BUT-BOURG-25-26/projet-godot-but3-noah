extends Node3D

class_name CharacterPlayer

@onready var animations_tree : AnimationTree = $AnimationTree
@onready var weapon_socket : Marker3D = $"character-m/root/torso/arm-right/weapon_socket"

func _ready() -> void:
	weapon_socket.add_child(GameManager.weapon)
	GameManager.weapon.global_position = weapon_socket.global_position

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die" :
		GameManager.game_over()
