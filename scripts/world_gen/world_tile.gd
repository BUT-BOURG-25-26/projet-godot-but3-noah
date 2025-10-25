extends Node3D

class_name  WorldTile

@export var neighbors_tiles : Array
@export var tiles_created : bool

func init_neighbors_tiles() -> void:
	tiles_created = false
	for i in range(-1, 2):
		for j in range(-1, 2):
			neighbors_tiles.append(Vector2(global_position.x+j*20, global_position.z+i*20))

func create_neighbors_tiles() -> void:
	for i in range(9):
		var pos : Vector2 = neighbors_tiles[i]
		GameManager.world_gen(pos.x, 0, pos.y)
