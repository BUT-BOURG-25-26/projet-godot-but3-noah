extends Node3D

class_name WorldGenerator

@export var snow_tile_scene : PackedScene
@export var tile_scene : PackedScene

@onready var christmas : bool = true

@export var tile_size : float = 20.0
@export var view_distance : int = 3
@export var unload_distance : int = 3

var loaded_tiles : Dictionary = {}
var last_player_tile : Vector2 = Vector2.INF
var player : Player

func _physics_process(delta: float) -> void:
	tiles_generation()
	
func tiles_generation() -> void:
	var current_tile = get_player_tile_coords()
	if current_tile != last_player_tile:
		update_tiles()
		last_player_tile = current_tile

func update_tiles():
	var player_tile = get_player_tile_coords()
	var new_tiles: Dictionary = {}
	for x in range(player_tile.x - view_distance, player_tile.x + view_distance + 1):
		for z in range(player_tile.y - view_distance, player_tile.y + view_distance + 1):
			var coord = Vector2(x, z)
			if not loaded_tiles.has(coord):
				var tile
				if christmas:
					tile = snow_tile_scene.instantiate()
				else :
					tile = tile_scene.instantiate()
				tile.position = Vector3(x * tile_size, 0, z * tile_size)
				add_child(tile)
				new_tiles[coord] = tile
			else:
				new_tiles[coord] = loaded_tiles[coord]
				loaded_tiles.erase(coord)
	for coord in loaded_tiles.keys():
		var dist = coord.distance_to(player_tile)
		if dist > unload_distance:
			loaded_tiles[coord].queue_free()
		else:
			new_tiles[coord] = loaded_tiles[coord]
	loaded_tiles = new_tiles

func get_player_tile_coords() -> Vector2:
	if player != null:
		var tx = floor((player.position.x + tile_size / 2.0) / tile_size)
		var tz = floor((player.position.z + tile_size / 2.0) / tile_size)
		return Vector2(tx, tz)
	return Vector2(0, 0)
