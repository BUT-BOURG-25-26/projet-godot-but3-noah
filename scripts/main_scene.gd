extends Node3D

@onready var level_up_stats_ui : Control = $LvlUpStats
@onready var game_over_ui : Control = $GameOver

@export var player_scene : PackedScene
@export var camera_scene : PackedScene
@export var zombie_spawner_scene : PackedScene
@export var world_tiles_generator_scene : PackedScene

var player : Player

func _ready() -> void:
	GameManager.origin_node = self
	GameManager.level_up_stats_ui = level_up_stats_ui
	GameManager.game_over_ui = game_over_ui
	
	var player = player_scene.instantiate()
	var camera : Node3D = camera_scene.instantiate()
	var zombie_spawner : Node3D = zombie_spawner_scene.instantiate()
	var world_tiles_generator : Node3D = world_tiles_generator_scene.instantiate()
	
	GameManager.player = player
	
	add_child(player)
	add_child(camera)
	add_child(zombie_spawner)
	add_child(world_tiles_generator)
	
	player.global_position = Vector3(0, 0, 0)
	camera.global_position = Vector3(0, 3.5, 7.5)
	zombie_spawner.global_position = Vector3(0, 0, 0)
	world_tiles_generator.global_position = Vector3(0, 0, 0)
	
	camera.rotate(Vector3(1, 0, 0), -0.26)
