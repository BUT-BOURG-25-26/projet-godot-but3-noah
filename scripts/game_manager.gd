extends Node

@onready var start_menu_scene : PackedScene = preload("res://scenes/ui/game_management/start_menu.tscn")
@onready var weapon_choice_scene : PackedScene = preload("res://scenes/ui/game_management/weapon_choice.tscn")
@onready var main_scene : PackedScene = preload("res://scenes/main_scene.tscn")

var level_up_stats_ui : LevelUpStats
var game_over_ui : GameOver
var stats_panel_ui : StatsPanel
var score_ui : ScoreUI

var origin_node : Node3D
var player : Player
var weapon : Weapon

var screensize : Vector2

var enemies_alive : int
var kill_count : int
var time_played : int

func start() -> void:
	get_tree().change_scene_to_packed(main_scene)

func quit() -> void :
	get_tree().quit()

func back_menu_start() -> void:
	get_tree().change_scene_to_packed(start_menu_scene)

func weapon_choice() -> void :
	get_tree().change_scene_to_packed(weapon_choice_scene)
	Engine.time_scale = 1.0

func game_over() -> void:
	game_over_ui.visible = true
	game_over_ui.time_survived_label.text = "You survived : "+str(time_played)+" seconds"
	Engine.time_scale = 0.0
	reset()

func level_up_stats() -> void:
	level_up_stats_ui.visible = true
	level_up_stats_ui.cards_roll()
	Engine.time_scale = 0.0

func reset() -> void:
	time_played = 0
	enemies_alive = 0
	kill_count = 0
