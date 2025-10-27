extends Camera3D

@export var offset : Vector3
var player : Player

func _ready() -> void:
	player = get_parent().get_node("Player")

func _process(delta: float) -> void:
	global_position = player.global_position + offset
	return
