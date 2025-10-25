extends Node3D

@export var world_tile_scene: PackedScene
@export var player_scene: PackedScene
@export var tile_size: float = 20.0
@export var view_distance: int = 1
@export var unload_distance: int = 2

var player: Player
var loaded_tiles: Dictionary = {}
var last_player_tile: Vector2 = Vector2.INF

func _ready() -> void:
	GameManager.init()
	
	update_tiles()
	
	var player_scene = player_scene.instantiate()
	add_child(player_scene)
	player_scene.global_position = Vector3(0, 0, 0)
	player = player_scene.get_child(0)

func _process(delta: float) -> void:
	var current_tile = get_player_tile_coords()
	if current_tile != last_player_tile:
		update_tiles()
		last_player_tile = current_tile

func update_tiles():
	var player_tile = get_player_tile_coords()
	print(player_tile)
	var new_tiles: Dictionary = {}

	for x in range(player_tile.x - view_distance, player_tile.x + view_distance + 1):
		for z in range(player_tile.y - view_distance, player_tile.y + view_distance + 1):
			var coord = Vector2(x, z)
			if not loaded_tiles.has(coord):
				var world_tile = world_tile_scene.instantiate()
				world_tile.position = Vector3(x * tile_size, 0, z * tile_size)
				add_child(world_tile)
				new_tiles[coord] = world_tile
			else:
				new_tiles[coord] = loaded_tiles[coord]
				loaded_tiles.erase(coord)

	# --- DÉCHARGEMENT ---
	for coord in loaded_tiles.keys():
		var dist = coord.distance_to(player_tile)
		if dist > unload_distance:
			loaded_tiles[coord].queue_free()
		else:
			new_tiles[coord] = loaded_tiles[coord]
	loaded_tiles = new_tiles

func get_player_tile_coords() -> Vector2:
	if player != null:
		var px = player.position.x
		var pz = player.position.z
		
		var tx = floor((px + tile_size / 2.0) / tile_size)
		var tz = floor((pz + tile_size / 2.0) / tile_size)
		return Vector2(tx, tz)
	return Vector2(0, 0)
