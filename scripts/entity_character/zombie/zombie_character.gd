extends Node3D

class_name CharacterZombie

@onready var animations_tree : AnimationTree = $AnimationTree

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "die" :
		get_parent().queue_free()
