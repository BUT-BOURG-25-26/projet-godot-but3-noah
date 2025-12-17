extends Spawner

class_name BaseMushroomSpawner

@export var base_mushroom_scene : PackedScene

func _ready() -> void:
	min_distance_player = 8.0
	max_distance_player = 13.0
	position_y = 0.5
	spawn_time = 1.5
	spawn_timer = $SpawnTimer
	spawn_timer.wait_time = spawn_time

func _on_spawn_timer_timeout() -> void:
	if !GameManager.player.is_dead:
		var base_mushroom : Monsters = base_mushroom_scene.instantiate()
		GameManager.original_node.add_child(base_mushroom)
		var spawn_vector = monster_spawn_range()
		base_mushroom.global_position = spawn_vector
