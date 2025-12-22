extends Node

@export var start_scene : PackedScene = preload("res://Scenes/start_scene.tscn")
@export var main_scene : PackedScene = preload("res://Scenes/main_scene.tscn")
@export var test_scene : PackedScene = preload("res://Scenes/test_scene.tscn")

var player : Player
var weapon_scene : PackedScene
var original_node : Node3D

var screen_size : Vector2
var xp_bar : XpBar
var level_up_ui : LevelUpUI
var enemies_count_ui : EnemiesCount
var score_ui : ScoreUI
var game_over_ui : GameOver

var enemies_alived : int
var enemies_killed : int
var score : int
var time_played : int

func start() -> void:
	get_tree().change_scene_to_packed(main_scene)

func quit() -> void:
	get_tree().quit()

func restart() -> void:
	Engine.time_scale = 1.0
	reset()
	get_tree().change_scene_to_packed(start_scene)

func game_over() -> void:
	game_over_ui.init_time_played(time_played)
	game_over_ui.visible = true

func reset() -> void:
	enemies_alived = 0
	enemies_killed = 0
	score = 0
	time_played = 0

func change_weapon(weapon_scene : PackedScene) -> void:
	player.change_weapon(weapon_scene)
	self.weapon_scene = weapon_scene

func level_up() -> void:
	level_up_ui.visible = true
	level_up_ui.cards_roll()
	Engine.time_scale = 0.0
