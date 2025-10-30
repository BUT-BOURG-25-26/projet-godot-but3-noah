extends Weapon

class_name Sniper

@onready var output : Marker3D = $"blaster-f/output"
@onready var player = GameManager.player

@export var bullet_scene : PackedScene
@export var shoot_vfx_scene : PackedScene

func _ready() -> void:
	damage = 15
	range = 15
	attack_speed = 0.5
	bullet_speed = 5

func shoot() -> void:
	var shoot_vfx : VFX = shoot_vfx_scene.instantiate()
	add_child(shoot_vfx)
	shoot_vfx.global_position = output.global_position
	
	var bullet : Node3D = bullet_scene.instantiate()
	bullet.target = player.nearest_enemy.global_position
	bullet.pos = output.global_position
	GameManager.origin_node.add_child(bullet)
	bullet.scale = Vector3(5, 5, 5)
