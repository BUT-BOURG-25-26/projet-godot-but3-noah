extends CharacterBody3D

class_name Zombie

@onready var player : Player = GameManager.player
@onready var character_zombie : CharacterZombie = $"character-l"
@onready var animation_tree : AnimationTree = character_zombie.get_node("AnimationTree")

@export var zombie_xp_scene : PackedScene
@export var xp_power_up_scene : PackedScene
@export var damage_power_up_scene : PackedScene
@export var attack_speed_power_up_scene : PackedScene
@export var speed_power_up_scene : PackedScene

@export var health : int
@export var attack : int
@export var movement_speed : float

var is_dead : bool = false

func _ready() -> void:
	health = 10
	attack = 3
	movement_speed = 3

func _physics_process(delta: float) -> void:
	if !is_dead :
		zombie_movement()
		if health<=0:
			is_dead = true
			power_up_appears()
			GameManager.kill_count+=1
			GameManager.enemies_alive-=1
			GameManager.score_ui.update()
			animation_tree.set("parameters/conditions/isDying", true)

func _on_tree_exiting() -> void:
	var zombie_xp : Node3D = zombie_xp_scene.instantiate()
	GameManager.origin_node.add_child(zombie_xp)
	zombie_xp.global_position = Vector3(global_position.x, 0.5, global_position.z)

func zombie_movement() -> void:
	var look_at_player : Vector3 = player.global_position
	look_at(look_at_player)
	var movement : Vector3 = player.global_position - global_position
	movement = movement.normalized()
	velocity = movement * movement_speed
	if !is_on_floor() :
		velocity.y = get_gravity().y
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is Player:
			player.take_damage(attack)
			is_dead = true
			animation_tree.set("parameters/conditions/isDying", true)
	if movement_speed >= 5:
		animation_tree.set("parameters/conditions/isSprinting", true)
	else:
		animation_tree.set("parameters/conditions/isWalking", true)
	move_and_slide()

func power_up_appears() -> void:
	var luck : int = int(randf_range(0, 10))
	var power_up : StaticBody3D
	if luck == 5:
		power_up = xp_power_up_scene.instantiate()
	if luck == 8:
		power_up = damage_power_up_scene.instantiate()
	if luck == 3:
		power_up = attack_speed_power_up_scene.instantiate()
	if luck == 1:
		power_up = speed_power_up_scene.instantiate()
	if power_up!=null:
		GameManager.origin_node.add_child(power_up)
		power_up.global_position = global_position
		power_up.global_position.y = 0.5
