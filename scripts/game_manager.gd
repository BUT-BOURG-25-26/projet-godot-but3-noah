extends Node

@onready var main_scene: PackedScene = preload("res://scenes/main_scene.tscn")

func init() -> void:
	pass

func start() -> void:
	get_tree().change_scene_to_packed(main_scene)
