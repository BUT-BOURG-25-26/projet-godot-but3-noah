extends Node3D
class_name Bullet

@export var target: Zombie
@export var damage: int
@export var speed: float = 2.0
@export var pos: Vector3

var direction: Vector3

func _ready() -> void:
	global_position = pos
	if target and is_instance_valid(target):
		direction.x = target.global_position.x - pos.x
		direction.z = target.global_position.z - pos.z
		direction = direction.normalized()

func _physics_process(delta: float) -> void:
	translate(direction * speed * delta)
	if global_position.distance_to(GameManager.player.global_position) > 30:
		print("trop loin")
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Zombie:
		body.health -= damage
		queue_free()
