extends CharacterBody3D

class_name Zombie

var player : Player

@export var health : int
@export var attack : int
@export var movement_speed : float

func _ready() -> void:
	health = 10
	attack = 3
	movement_speed = 3
	
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta: float) -> void:
	
	var look_at_player = player.position
	look_at(look_at_player)
	
	var movement : Vector3 = player.global_position - global_position
	movement = movement.normalized()
	velocity = movement * movement_speed
	if !is_on_floor() :
		velocity.y = get_gravity().y
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is Player:
			queue_free()
	move_and_slide()
