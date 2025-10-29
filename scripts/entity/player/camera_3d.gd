extends Camera3D

@export var offset : Vector3
var player : Player

func _ready() -> void:
	player = GameManager.player

func _process(delta: float) -> void:
	global_position = player.global_position + offset
	return
