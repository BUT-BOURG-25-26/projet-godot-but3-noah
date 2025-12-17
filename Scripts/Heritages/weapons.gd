extends Node3D

class_name Weapons

@export var bullet_scene : PackedScene = preload("res://Scenes/Weapons/bullet.tscn")

@onready var output : Marker3D = $output1

@export var damage_ratio : float
@export var attack_speed_ratio : float
@export var range_ratio : float
@export var bullet_speed : float

func shoot(damage) -> void:
	var bullet : Bullet = bullet_scene.instantiate()
	bullet.target = GameManager.player.nearest_enemy.target.global_position
	bullet.speed = bullet_speed
	bullet.damage = damage
	bullet.pos = output.global_position
	GameManager.original_node.add_child(bullet)
	bullet.global_position = output.global_position
