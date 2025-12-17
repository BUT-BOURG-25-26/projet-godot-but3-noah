extends Node3D

class_name GlubProjectile

@onready var player : Player = GameManager.player
@export var damage : float
@export var range : float
@export var speed : float
@export var pos : Vector3
var direction: Vector3

func _ready() -> void:
	global_position = pos
	if player.global_position!=Vector3.ZERO:
		direction.x = player.target.global_position.x - global_position.x
		direction.y = player.target.global_position.y - global_position.y
		direction.z = player.target.global_position.z - global_position.z
		direction = direction.normalized()

func _physics_process(delta: float) -> void:
	translate(direction * speed * delta)
	if global_position.distance_to(player.global_position) > range+5:
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		player.take_damage(damage)
		queue_free()
