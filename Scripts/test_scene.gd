extends Node3D

@export var player_scene : PackedScene
@export var world_generator_scene : PackedScene

func _ready() -> void:
	GameManager.original_node = self
	GameManager.screen_size = get_viewport().size
	GameManager.xp_bar = $Xpbar
	GameManager.xp_bar.update(0)
	GameManager.level_up_ui = $LevelUp
	
	var player : Player = player_scene.instantiate()
	var world_generator : WorldGenerator = world_generator_scene.instantiate()
	
	player.weapon = GameManager.weapon
	add_child(player)
	world_generator.player = player
	add_child(world_generator)
	
	player.global_position = Vector3(0, 0.5, 0)
	world_generator.global_position = Vector3(0, 0, 0)
	
	GameManager.player = player
