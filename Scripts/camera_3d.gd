extends Camera3D

class_name Camera

@export var offset : Vector3
@export var max_offset : Vector3
@export var min_offset : Vector3
@export var player : Player

func _ready() -> void:
	max_offset = offset + Vector3(0, 3, 3)
	min_offset = offset

func _process(delta: float) -> void:
	#if player.speed_power_up_active:
		#if offset <= max_offset:
			#offset = offset + Vector3(0, 0.01, 0.01)
	#else:
		#if offset >= min_offset:
			#offset = offset - Vector3(0, 0.01, 0.01)
	global_position = player.global_position + offset
	return
