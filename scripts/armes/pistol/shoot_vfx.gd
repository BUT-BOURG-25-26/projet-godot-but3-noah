extends Area3D 

class_name VFX

@onready var flash = $Flash

func emit():
	flash.emitting = true

func _on_flash_finished() -> void:
	queue_free()
