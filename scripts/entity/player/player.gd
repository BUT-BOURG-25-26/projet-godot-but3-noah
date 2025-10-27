extends CharacterBody3D

class_name Player

@export var joystick_scene: PackedScene

var joystick_displayed : bool
var joystick : Node2D

@export var health : int
@export var attack_damage : int
@export var attack_speed : float
@export var movement_speed : float
@export var xp : int
@export var level_xp_amount : int
@export var level : int

func _ready() -> void:
	health = 10
	attack_damage = 5
	attack_speed = 1
	movement_speed = 5
	xp = 0
	level_xp_amount = 200
	level = 1

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left_mouse_click"):
		if !joystick_displayed:
			joystick_displayed=true
			joystick = joystick_scene.instantiate()
			joystick.global_position = get_viewport().get_mouse_position()
			add_child(joystick)
	else:
		if joystick_displayed:
			joystick_displayed = false
			joystick.queue_free()
			
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

func gain_xp(xp_amount) -> void:
	xp+=xp_amount
	level_up()

func level_up() -> void:
	if xp >= level_xp_amount:
		print("Level up !!")
		level+=1
		level_xp_amount = level_xp_amount*2 - xp
		xp = 0
