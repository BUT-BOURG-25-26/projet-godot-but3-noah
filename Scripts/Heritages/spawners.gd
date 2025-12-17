extends Node3D

class_name Spawner

@export var min_distance_player : float
@export var max_distance_player : float
@export var position_y : float
@export var spawn_time : float
@export var spawn_timer : Timer

func monster_spawn_range() -> Vector3:
	var spawn_vector: Vector3 = Vector3.ZERO
	var distance_to_player: float = 0.0
	var player = GameManager.player
	while distance_to_player <= min_distance_player:
		var x = randf_range(player.global_position.x - max_distance_player, player.global_position.x + max_distance_player)
		var y = position_y
		var z = randf_range(player.global_position.z - max_distance_player, player.global_position.z + max_distance_player)
		spawn_vector = Vector3(x, y, z)
		var direction_to_player: Vector3 = player.global_position - spawn_vector
		distance_to_player = direction_to_player.length()
	GameManager.enemies_alived+=1
	GameManager.enemies_count_ui.update()
	return spawn_vector

func change_spawn_time(new_spawn_time) -> void:
	spawn_time = new_spawn_time
	spawn_timer.wait_time = spawn_time
