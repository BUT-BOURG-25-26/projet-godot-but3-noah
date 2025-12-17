extends Node3D

@onready var player : Player = $Player
@onready var camera : Camera = $Camera3D

var spawn_position : Vector3 = Vector3(-17, 0, 18)

func _ready() -> void:
	GameManager.player = player
	init_player()

func _physics_process(delta: float) -> void:
	player_fall()

func init_player() -> void:
	player.speed = 10
	player.health_bar.visible = false

func player_fall() -> void:
	if player.global_position.y < -8:
		player.global_position = spawn_position

func _on_quit_area_body_entered(body: Node3D) -> void:
	if body is Player :
		GameManager.quit()

func _on_start_area_body_entered(body: Node3D) -> void:
	if body is Player && GameManager.weapon_scene != null:
		GameManager.start()
