extends Node3D

class_name Pistol

@export var output : Marker3D

func _ready() -> void:
	output = $"blaster-b/output"
