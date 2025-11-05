extends Node3D

@onready var timer : Timer = $Timer
@export var zombie_scene : PackedScene
@export var min_distance_player = 5.0
@export var max_spawn_distance = 10.0
@export var spawn_time : float

func _ready() -> void:
	spawn_time = 0.75
	timer.wait_time = spawn_time

func _on_timer_timeout() -> void:
	var zombie: Zombie = zombie_scene.instantiate()
	add_child(zombie)
	GameManager.enemies_alive+=1
	GameManager.score_ui.update()
	var spawn_vector = zombie_spawn_range()
	zombie.global_position = spawn_vector

func zombie_spawn_range() -> Vector3:
	var spawn_vector: Vector3 = Vector3.ZERO
	var distance_to_player: float = 0.0
	var player = GameManager.player
	while distance_to_player <= min_distance_player:
		var x = randf_range(player.global_position.x - max_spawn_distance, player.global_position.x + max_spawn_distance)
		var y = 0.5
		var z = randf_range(player.global_position.z - max_spawn_distance, player.global_position.z + max_spawn_distance)
		spawn_vector = Vector3(x, y, z)
		var direction_to_player: Vector3 = player.global_position - spawn_vector
		distance_to_player = direction_to_player.length()
	return spawn_vector
