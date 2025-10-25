extends CharacterBody3D

class_name Player

@export var health : int
@export var attack_damage : int
@export var attack_speed : float
@export var movement_speed : float

func _ready() -> void:
	health = 10
	attack_damage = 5
	attack_speed = 1
	movement_speed = 5

func _physics_process(delta: float) -> void:
	player_movement()
	

func player_movement() -> void:
	var move_inputs = read_move_inputs()
	velocity = move_inputs * movement_speed
	if velocity != Vector3.ZERO:
		var look_at_point = global_position + (move_inputs * 5.0)
		look_at(look_at_point)
	if !is_on_floor():
		velocity.y = get_gravity().y
	move_and_slide()

func read_move_inputs() -> Vector3:
	var move_inputs : Vector3
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return move_inputs
