extends Node3D

@export var world_tile_scene : PackedScene
@export var player_scene : PackedScene

func _ready() -> void:
	
	var world_tile : Node3D = world_tile_scene.instantiate()
	add_child(world_tile)
	world_tile.global_position = Vector3(0, 0, 0)
	
	var player = player_scene.instantiate()
	add_child(player)
	player.global_position = Vector3(0, 3, 0)
	
	GameManager.init()
