extends Node3D

class_name Bullet

@onready var player : Player = GameManager.player
@onready var weapon : Weapon = GameManager.weapon

@onready var speed : float = weapon.bullet_speed
@onready var target : Vector3

@export var pos : Vector3
@export var angle_x : float
@export var angle_y : float
@export var angle_z : float

var direction: Vector3

func _ready() -> void:
	global_position = pos
	global_rotation_degrees.x = angle_x
	global_rotation_degrees.y = angle_y
	global_rotation_degrees.z = angle_z
	if target!=Vector3.ZERO:
		direction.x = target.x - global_position.x
		direction.z = target.z - global_position.z
		direction = direction.normalized()

func _physics_process(delta: float) -> void:
	translate(direction * speed * delta)
	if global_position.distance_to(player.global_position) > player.range:
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Zombie:
		body.health -= player.attack_damage
		queue_free()
