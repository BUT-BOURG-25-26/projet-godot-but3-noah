extends CharacterBody3D

class_name Player

@export var joystick_scene: PackedScene
var joystick_displayed : bool
var joystick : Node2D

@onready var character_player : CharacterPlayer = $"character-m"
@onready var animation_tree : AnimationTree = $"character-m/AnimationTree"
@onready var range_area : CollisionShape3D = $range/CollisionShape3D
@onready var timer_attack : Timer = $Timer

@export var health : int
@export var attack_damage : int
@export var attack_speed : float
@export var movement_speed : float
@export var range : float
@export var xp : int
@export var level_xp_amount : int
@export var level : int

@export var is_dead : bool = false
@export var is_aiming : bool = false
@export var is_walking : bool = false

var nearest_enemy : Zombie
var enemies_in_range : Array[Zombie] = []

func _ready() -> void:
	health = 10
	attack_damage = 5
	attack_speed = 1
	movement_speed = 7
	range = 7
	xp = 0
	level_xp_amount = 200
	level = 1
	
	var area : SphereShape3D = range_area.shape
	area.radius = range
	
	timer_attack.wait_time = 1.0 / attack_speed

func _physics_process(delta: float) -> void:
	if !is_dead:
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
		player_aim()
		player_movement()
		player_animations()

func player_movement() -> void:
	var move_inputs = read_move_inputs()
	velocity = move_inputs * movement_speed
	var look_at_point
	if nearest_enemy!=null:
		look_at_point = nearest_enemy.global_position
	else:
		if velocity != Vector3.ZERO:
			look_at_point = global_position + velocity
	if look_at_point!=null:
		look_at(look_at_point)
	if !is_on_floor():
		velocity.y = get_gravity().y
	move_and_slide()

func player_aim() -> void:
	if nearest_enemy!=null:
		is_aiming = true
	else:
		is_aiming = false

func read_move_inputs() -> Vector3:
	var move_inputs : Vector3
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	if move_inputs != Vector3.ZERO:
		is_walking = true
	else:
		is_walking = false
	return move_inputs

func player_animations() -> void:
	animation_tree.set("parameters/conditions/isIdle", !is_walking and !is_aiming)
	animation_tree.set("parameters/conditions/isWalking", is_walking and !is_aiming)
	animation_tree.set("parameters/conditions/isIdleHolding", !is_walking and is_aiming)
	animation_tree.set("parameters/conditions/isWalkingHolding", is_walking and is_aiming)
	animation_tree.set("parameters/conditions/isIdleShooting", false)
	animation_tree.set("parameters/conditions/isWalkingShooting", false)

func take_damage(damage_amount) -> void:
	health-=damage_amount
	if health<=0:
		is_dead = true
		animation_tree.set("parameters/conditions/isDying", true)

func gain_xp(xp_amount) -> void:
	xp+=xp_amount
	level_up()

func level_up() -> void:
	if xp >= level_xp_amount:
		print("Level up !!")
		level+=1
		level_xp_amount = level_xp_amount*2 - xp
		xp = 0

func update_nearest_enemy() -> void:
	if enemies_in_range.is_empty():
		nearest_enemy = null
		return
	var closest : Zombie = enemies_in_range[0]
	if closest!=null:
		var closest_dist = global_position.distance_to(closest.global_position)
		for enemy in enemies_in_range:
			if not is_instance_valid(enemy):
				continue
			var dist = global_position.distance_to(enemy.global_position)
			if dist < closest_dist:
				closest = enemy
				closest_dist = dist
	nearest_enemy = closest

func _on_range_body_entered(body: Node3D) -> void:
	if body is Zombie:
		var zombie: Zombie = body
		# Eviter les doublons
		if zombie not in enemies_in_range:
			enemies_in_range.append(zombie)
			update_nearest_enemy()

func _on_range_body_exited(body: Node3D) -> void:
	if body is Zombie and body in enemies_in_range:
		enemies_in_range.erase(body)
		if body == nearest_enemy:
			nearest_enemy = null
		update_nearest_enemy()

func _on_timer_timeout() -> void:
	if nearest_enemy!=null:
		character_player.attack(attack_damage, nearest_enemy)
