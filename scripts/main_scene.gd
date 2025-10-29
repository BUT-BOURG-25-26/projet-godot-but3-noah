extends Node3D

@export var player_scene: PackedScene
@export var camera_scene: PackedScene
@export var zombie_spawner_scene: PackedScene

var player: Player

func _ready() -> void:
	GameManager.origin_node = self
	
	var player = player_scene.instantiate()
	var camera : Node3D = camera_scene.instantiate()
	var zombie_spawner : Node3D = zombie_spawner_scene.instantiate()
	
	GameManager.player = player
	
	add_child(player)
	add_child(camera)
	add_child(zombie_spawner)
	
	player.global_position = Vector3(0, 0, 0)
	camera.global_position = Vector3(0, 3.5, 7.5)
	zombie_spawner.global_position = Vector3(0, 0, 0)
	
	camera.rotate(Vector3(1, 0, 0), -0.26)
	
	GameManager.update_tiles()
