extends Node3D

@onready var level_up_stats_ui : Control = $LvlUpStats
@onready var game_over_ui : Control = $GameOver
@onready var stats_panel_ui : Control = $StatsPanel
@onready var score_ui : Control = $ScoreUi

@export var player_scene : PackedScene
@export var camera_scene : PackedScene
@export var zombie_spawner_scene : PackedScene
@export var world_tiles_generator_scene : PackedScene

var player : Player
var zombie_spawner : ZombieSpawner

func _ready() -> void:
	GameManager.origin_node = self
	GameManager.level_up_stats_ui = level_up_stats_ui
	GameManager.game_over_ui = game_over_ui
	GameManager.stats_panel_ui = stats_panel_ui
	GameManager.score_ui = score_ui
	
	var player = player_scene.instantiate()
	var camera : Node3D = camera_scene.instantiate()
	zombie_spawner = zombie_spawner_scene.instantiate()
	var world_tiles_generator : Node3D = world_tiles_generator_scene.instantiate()
	
	GameManager.player = player
	GameManager.stats_panel_ui.init()
	
	add_child(player)
	add_child(camera)
	add_child(zombie_spawner)
	add_child(world_tiles_generator)
	
	player.global_position = Vector3(0, 0, 0)
	camera.global_position = Vector3(0, 3.5, 7.5)
	zombie_spawner.global_position = Vector3(0, 0, 0)
	world_tiles_generator.global_position = Vector3(0, 0, 0)
	
	camera.rotate(Vector3(1, 0, 0), -0.26)
	
	GameManager.screensize = get_viewport().size

func _on_timer_timeout() -> void:
	GameManager.time_played+=1
	zombie_spawner.change_spawn_time(zombie_spawner.spawn_time-0.005)
