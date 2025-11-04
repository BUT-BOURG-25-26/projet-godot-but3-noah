extends Node

@onready var weapon_choice_scene : PackedScene = preload("res://scenes/ui/weapon_choice.tscn")
@onready var main_scene : PackedScene = preload("res://scenes/main_scene.tscn")

var level_up_stats_ui : LevelUpStats
var game_over_ui : Control
var stats_panel_ui : StatsPanel

var origin_node : Node3D
var player : Player
var weapon : Weapon

var enemies_alive : int
var kill_count : int

func start() -> void:
	get_tree().change_scene_to_packed(main_scene)

func quit() -> void :
	get_tree().quit()

func restart() -> void :
	get_tree().change_scene_to_packed(weapon_choice_scene)
	Engine.time_scale = 1.0

func game_over() -> void:
	game_over_ui.visible = true
	Engine.time_scale = 0.0

func level_up_stats() -> void:
	level_up_stats_ui.visible = true
	level_up_stats_ui.cards_roll()
	Engine.time_scale = 0.0
