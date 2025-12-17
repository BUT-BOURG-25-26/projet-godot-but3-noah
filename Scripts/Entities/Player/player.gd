extends CharacterBody3D

class_name Player

@onready var animation_tree : AnimationTree = $adventurer/AnimationTree
@onready var health_bar : HealthBar = $HealthSubViewport/Healthbar
@onready var weapon_marker : Marker3D = $"adventurer/character-m/root/torso/arm-right/Marker3D"
@onready var shoot_timer : Timer = $shoot_timer
@onready var target : Marker3D = $target
@onready var detection_range_shape : SphereShape3D = $DetectionRange/CollisionShape3D.shape

@onready var damage_power_up_timer: Timer = $damage_power_up_timer
@onready var attack_speed_power_up_timer: Timer = $attack_speed_power_up_timer
@onready var speed_power_up_timer: Timer = $speed_power_up_timer
@export var damage_power_up_active : bool
@export var attack_speed_power_up_active : bool
@export var speed_power_up_active : bool
@export var damage_power_up_received : bool
@export var attack_speed_power_up_received : bool
@export var speed_power_up_received : bool

@export var joystick_sceneee: PackedScene
var joystick_displayed : bool
var joystick : Node2D

@export var weapon : Weapons

@export var max_health : float
@export var health : float
@export var damage : float
@export var attack_speed : float
@export var speed : float
@export var range : float

@export var level : int
@export var xp : float
@export var xp_floor_amount : float
@export var attract_xp_orbs : bool = false

@export var is_moving : bool
@export var is_aiming : bool
@export var is_dead : bool

@export var nearest_enemy : Monsters
@export var enemies_in_range : Array[Monsters] = []

func _ready() -> void:
	max_health = 10
	health = 10
	damage = 5
	attack_speed = 1
	range = 8
	speed = 5
	
	level = 1
	xp = 0
	xp_floor_amount = 100
	
	health_bar.init(max_health)

func _physics_process(delta: float) -> void:
	if !is_dead:
		player_movement()
		player_animations()
		joystick_manager()
		power_up_manager()
		player_aim()
		level_up()
	else:
		shoot_timer.stop()

func change_weapon(weapon_scene : PackedScene) -> void:
	if weapon != null:
		weapon.queue_free()
	var new_weapon : Weapons = weapon_scene.instantiate()
	weapon = new_weapon
	weapon_marker.add_child(weapon)
	weapon.global_position = weapon_marker.global_position
	detection_range_shape.radius = range * weapon.range_ratio
	shoot_timer.wait_time = 1/(attack_speed * weapon.attack_speed_ratio)
	shoot_timer.start()

func player_animations() -> void:
	animation_tree.set("parameters/conditions/isIdle", !is_moving && !is_aiming)
	animation_tree.set("parameters/conditions/isIdleShooting", !is_moving && is_aiming)
	animation_tree.set("parameters/conditions/isWalking", is_moving && !is_aiming)
	animation_tree.set("parameters/conditions/isWalkShooting", is_moving && is_aiming)

func player_movement() -> void:
	var move_inputs = read_move_inputs()
	velocity = move_inputs * speed
	var look_at_point
	if nearest_enemy!=null:
		look_at_point = nearest_enemy.global_position
	else:
		if velocity != Vector3.ZERO:
			look_at_point = global_position + velocity
	if look_at_point!=null:
		look_at_point.y = position.y
		look_at(look_at_point)
	if !is_on_floor():
		velocity.y = get_gravity().y
	move_and_slide()

func read_move_inputs() -> Vector3:
	var move_inputs : Vector3
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	if move_inputs == Vector3.ZERO:
		is_moving = false
	else:
		is_moving = true
	return move_inputs

func take_damage(damage) -> void:
	health -= damage
	health_bar.update(health)
	if health<=0:
		health=0
		is_dead = true
		animation_tree.set("parameters/conditions/isDying", is_dead)
		GameManager.game_over()

func power_up_manager() -> void:
	if damage_power_up_received:
		damage_power_up_timer.stop()
		damage_power_up_timer.start()
		damage_power_up_active = true
		damage_power_up_received = false
	if attack_speed_power_up_received:
		attack_speed_power_up_timer.stop()
		attack_speed_power_up_timer.start()
		attack_speed_power_up_active = true
		attack_speed_power_up_received = false
	if speed_power_up_received:
		speed_power_up_timer.stop()
		speed_power_up_timer.start()
		speed_power_up_active = true
		speed_power_up_received = false

func joystick_manager() -> void:
	if Input.is_action_pressed("left_mouse_click"):
		if !joystick_displayed:
			joystick_displayed=true
			joystick = joystick_sceneee.instantiate()
			joystick.global_position = get_viewport().get_mouse_position()
			add_child(joystick)
	else:
		if joystick_displayed:
			joystick_displayed = false
			joystick.queue_free()

func player_aim() -> void:
	if nearest_enemy!=null:
		is_aiming = true
	else:
		is_aiming = false

func update_nearest_enemy() -> void:
	if enemies_in_range.is_empty():
		nearest_enemy = null
		return
	var closest : Monsters = enemies_in_range[0]
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

func level_up() -> void:
	if xp >= xp_floor_amount:
		level += 1
		xp = xp - xp_floor_amount
		GameManager.xp_bar.update(xp)
		xp_floor_amount += (level-1) * 100
		GameManager.level_up()

func change_attack_speed(attack_speed) -> void:
	self.attack_speed += attack_speed
	shoot_timer.wait_time = 1/(self.attack_speed * weapon.attack_speed_ratio)

func change_range(range) -> void:
	self.range += range
	detection_range_shape.radius = self.range * weapon.range_ratio

func _on_detection_range_body_entered(body: Node3D) -> void:
	if body is Monsters:
		var monster: Monsters = body
		if monster not in enemies_in_range:
			enemies_in_range.append(monster)
			update_nearest_enemy()

func _on_detection_range_body_exited(body: Node3D) -> void:
	if body is Monsters and body in enemies_in_range:
		enemies_in_range.erase(body)
		if body == nearest_enemy:
			nearest_enemy = null
		update_nearest_enemy()

func _on_shoot_timer_timeout() -> void:
	if is_aiming && nearest_enemy!=null:
		weapon.shoot(damage * weapon.damage_ratio)

func _on_damage_power_up_timer_timeout() -> void:
	damage -= 4
	damage_power_up_active = false

func _on_attack_speed_power_up_timer_timeout() -> void:
	change_attack_speed(-0.25)
	attack_speed_power_up_active = false

func _on_speed_power_up_timer_timeout() -> void:
	speed -= 3
	speed_power_up_active = false
