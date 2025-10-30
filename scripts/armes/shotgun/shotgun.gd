extends Weapon

class_name Shotgun

@onready var output : Marker3D = $"blaster-h/output"
@onready var player = GameManager.player

@export var bullet_scene : PackedScene
@export var shoot_vfx_scene : PackedScene

func _ready() -> void:
	damage = 8
	range = 5
	attack_speed = 0.8
	bullet_speed = 3.5

func shoot() -> void:
	var shoot_vfx : VFX = shoot_vfx_scene.instantiate()
	add_child(shoot_vfx)
	shoot_vfx.global_position = output.global_position
	
	for i in range(6):
		var bullet : Node3D = bullet_scene.instantiate()
		bullet.target = player.nearest_enemy.global_position
		bullet.pos = output.global_position
		bullet.angle_x = randf_range(-20, 20)
		bullet.angle_y = randf_range(-20, 20)
		bullet.angle_z = randf_range(-20, 20)
		GameManager.origin_node.add_child(bullet)
		bullet.scale = Vector3(5, 5, 5)
