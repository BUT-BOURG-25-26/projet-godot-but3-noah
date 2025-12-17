extends Node3D

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "CharacterArmature|Death":
		get_parent().queue_free()
