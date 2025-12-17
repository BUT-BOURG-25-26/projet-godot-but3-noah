extends Spawner

class_name BaseGlubSpawner

@export var base_glub_scene : PackedScene

func _ready() -> void:
	min_distance_player = 10.0
	max_distance_player = 20.0
	position_y = 5.0
	spawn_time = 4
	spawn_timer = $SpawnTimer
	spawn_timer.wait_time = spawn_time

func _on_spawn_timer_timeout() -> void:
	if !GameManager.player.is_dead:
		var base_glub : Monsters = base_glub_scene.instantiate()
		GameManager.original_node.add_child(base_glub)
		var spawn_vector = monster_spawn_range()
		base_glub.global_position = spawn_vector
