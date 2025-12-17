extends Node3D

class_name MainScene

@onready var player : Player = $Player
@onready var camera : Camera = $Camera3D
@onready var world_generator : WorldGenerator = $WorldGenerator
@onready var xp_bar: XpBar = $Xpbar
@onready var level_up: LevelUpUI = $LevelUp
@onready var enemies_count: EnemiesCount = $EnemiesCount
@onready var score_ui: ScoreUI = $ScoreUi
@onready var game_over : GameOver = $GameOver
@onready var base_glub_spawner: BaseGlubSpawner = $BaseGlubSpawner
@onready var base_mushroom_spawner: BaseMushroomSpawner = $BaseMushroomSpawner

func _ready() -> void:
	GameManager.original_node = self
	GameManager.screen_size = get_viewport().size
	GameManager.player = player
	GameManager.xp_bar = xp_bar
	GameManager.xp_bar.update(0)
	GameManager.level_up_ui = level_up
	GameManager.enemies_count_ui = enemies_count
	GameManager.score_ui = score_ui
	GameManager.game_over_ui = game_over
	player.change_weapon(GameManager.weapon_scene)
	player.health_bar.visible = true
	camera.player = player
	world_generator.player = player

func _on_timer_timeout() -> void:
	GameManager.time_played+=1
	base_glub_spawner.change_spawn_time(base_glub_spawner.spawn_time-0.0005)
	base_mushroom_spawner.change_spawn_time(base_mushroom_spawner.spawn_time-0.005)
