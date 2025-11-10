extends CharacterBody3D

class_name Player

@export var joystick_scene: PackedScene
var joystick_displayed : bool
var joystick : Node2D

@onready var character_player : CharacterPlayer = $"character-m"
@onready var animation_tree : AnimationTree = $"character-m/AnimationTree"
@onready var area : CollisionShape3D = $range/CollisionShape3D

@onready var timer_attack : Timer = $TimerAttack
@onready var timer_power_up_attack_speed : Timer = $TimerPowerUpAttackSpeed
@onready var timer_power_up_speed : Timer = $TimerPowerUpSpeed
@onready var timer_power_up_damage : Timer = $TimerPowerUpDamage

@export var range_area : SphereShape3D

@export var health : int
@export var max_health : int
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

@export var speed_power_up_received : bool = false
@export var speed_power_up_active : bool = false
@export var attack_speed_power_up_received : bool = false
@export var attack_speed_power_up_active : bool = false
@export var damage_power_up_received : bool = false
@export var damage_power_up_active : bool = false
@export var attract_xp_orbs : bool = false

@export var nearest_enemy : Zombie
@export var enemies_in_range : Array[Zombie] = []

func _ready() -> void:
	max_health = 10
	health = 10
	attack_damage = GameManager.weapon.damage
	attack_speed = GameManager.weapon.attack_speed
	movement_speed = 7
	range = GameManager.weapon.range
	xp = 0
	level_xp_amount = 50
	level = 1
	
	range_area = area.shape
	range_area.radius = range
	
	GameManager.stats_panel_ui.update()
	
	timer_attack.wait_time = 1.0 / attack_speed

func _physics_process(delta: float) -> void:
	if !is_dead:
		joystick_manager()
		player_aim()
		player_movement()
		player_animations()
		gestion_power_up()

func joystick_manager() -> void:
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
	animation_tree.set("parameters/conditions/isWalking", is_walking and !is_aiming and !speed_power_up_active)
	animation_tree.set("parameters/conditions/isIdleHolding", !is_walking and is_aiming)
	animation_tree.set("parameters/conditions/isWalkingHolding", is_walking and is_aiming and !speed_power_up_active)
	animation_tree.set("parameters/conditions/isSprinting", is_walking and !is_aiming and speed_power_up_active)
	animation_tree.set("parameters/conditions/isSprintingHolding", is_walking and is_aiming and speed_power_up_active)

func take_damage(damage_amount) -> void:
	health-=damage_amount
	if health<=0:
		health=0
		is_dead = true
		animation_tree.set("parameters/conditions/isDying", true)

func attack_speed_change(attack_speed) -> void:
	self.attack_speed += attack_speed
	timer_attack.wait_time = 1.0 / self.attack_speed

func range_change(range) -> void:
	self.range += range
	range_area.radius = range

func gain_xp(xp_amount) -> void:
	xp+=xp_amount
	level_up()

func level_up() -> void:
	if xp >= level_xp_amount:
		level+=1
		level_xp_amount = level_xp_amount+level*100
		xp = 0
		GameManager.stats_panel_ui.update()
		GameManager.level_up_stats()

func gestion_power_up() -> void:
	if attack_speed_power_up_received:
		attack_speed_power_up_active = true
		attack_speed_power_up_received = false
		timer_power_up_attack_speed.start()
		GameManager.stats_panel_ui.update()
	if speed_power_up_received:
		speed_power_up_active = true
		speed_power_up_received = false
		timer_power_up_speed.start()
		GameManager.stats_panel_ui.update()
	if damage_power_up_received:
		damage_power_up_active = true
		damage_power_up_received = false
		timer_power_up_damage.start()
		GameManager.stats_panel_ui.update()

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
		if zombie not in enemies_in_range:
			enemies_in_range.append(zombie)
			update_nearest_enemy()

func _on_range_body_exited(body: Node3D) -> void:
	if body is Zombie and body in enemies_in_range:
		enemies_in_range.erase(body)
		if body == nearest_enemy:
			nearest_enemy = null
		update_nearest_enemy()

func _on_timer_attack_timeout() -> void:
	if is_aiming && nearest_enemy!=null:
		GameManager.weapon.shoot()

func _on_timer_power_up_attack_speed_timeout() -> void:
	attack_speed_power_up_active = false
	attack_speed_change(-1)
	GameManager.stats_panel_ui.update()

func _on_timer_power_up_speed_timeout() -> void:
	speed_power_up_active = false
	movement_speed-=3
	GameManager.stats_panel_ui.update()

func _on_timer_power_up_damage_timeout() -> void:
	damage_power_up_active = false
	attack_damage-=10
	GameManager.stats_panel_ui.update()
