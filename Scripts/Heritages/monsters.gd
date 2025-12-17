extends CharacterBody3D

class_name Monsters

@export var xp_scene : PackedScene = preload("res://Scenes/Entities/Monsters/xp_orb.tscn")
@export var power_up_scene : PackedScene = preload("res://Scenes/PowerUps/power_up.tscn")

@onready var animation_tree : AnimationTree = $mob/AnimationTree
@onready var target : Marker3D = $target

@export var health : float
@export var damage : float
@export var speed : float
@export var range : float
@export var xp_amount : float
@export var score : int

@export var player : Player

@export var is_dead : bool
@export var is_dancing : bool

func enemy_movement() -> void:
	var movement : Vector3
	movement.x = player.global_position.x - global_position.x
	movement.z = player.global_position.z - global_position.z
	movement = movement.normalized()
	velocity = movement * speed
	move_and_slide()

func look_at_player() -> void:
	var look_at_player : Vector3 = player.global_position
	look_at(look_at_player)

func collision() -> void:
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is Player:
			player.take_damage(damage)
			is_dead = true
			GameManager.enemies_killed+=1
			GameManager.enemies_alived-=1
			GameManager.enemies_count_ui.update()
			var xp : XpOrb = xp_scene.instantiate()
			xp.amount = xp_amount
			GameManager.original_node.call_deferred("add_child", xp)
			xp.global_position = Vector3(global_position.x, 1, global_position.z)
			animation_tree.set("parameters/conditions/isDying", true)
			return

func death() -> void:
	if health<=0:
		is_dead = true
		GameManager.enemies_killed+=1
		GameManager.enemies_alived-=1
		GameManager.enemies_count_ui.update()
		GameManager.score+=score
		GameManager.score_ui.update()
		var power_up : PowerUp = power_up_scene.instantiate()
		var luck : int = randi_range(1, 50)
		var spawn_power_up : bool = false
		match luck:
			1:
				power_up.type = "attack speed"
				spawn_power_up = true
			12:
				power_up.type = "damage"
				spawn_power_up = true
			25:
				power_up.type = "speed"
				spawn_power_up = true
			50:
				power_up.type = "xp"
				spawn_power_up = true
		if spawn_power_up:
			spawn_power_up = false
			GameManager.original_node.add_child(power_up)
			power_up.global_position = Vector3(global_position.x, 1.5, global_position.z)
		var xp : XpOrb = xp_scene.instantiate()
		xp.amount = xp_amount
		GameManager.original_node.add_child(xp)
		xp.global_position = Vector3(global_position.x, 1, global_position.z)
		animation_tree.set("parameters/conditions/isDying", true)

func dance() -> void:
	animation_tree.set("parameters/conditions/isDancing", true)
