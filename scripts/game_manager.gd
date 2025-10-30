extends Node

@onready var main_scene: PackedScene = preload("res://scenes/main_scene.tscn")

var origin_node : Node3D
var player : Player
var weapon : Weapon

var enemies_alive : int
var kill_count : int

func start() -> void:
	get_tree().change_scene_to_packed(main_scene)
