extends Node3D

class_name Bullet

@onready var player : Player = GameManager.player
@export var target : Vector3
@export var pos : Vector3
@export var angle_x : float
@export var angle_y : float
@export var angle_z : float
@export var speed : float
@export var damage : float

var direction: Vector3

func _ready() -> void:
	global_position = pos
	global_rotation_degrees.x = angle_x
	global_rotation_degrees.y = angle_y
	global_rotation_degrees.z = angle_z
	if target!=Vector3.ZERO:
		direction.x = target.x - global_position.x
		direction.y = target.y - global_position.y
		direction.z = target.z - global_position.z
		direction = direction.normalized()

func _physics_process(delta: float) -> void:
	translate(direction * speed * delta)
	if global_position.distance_to(player.global_position) > player.range+10:
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Monsters:
		body.health -= damage
		queue_free()
