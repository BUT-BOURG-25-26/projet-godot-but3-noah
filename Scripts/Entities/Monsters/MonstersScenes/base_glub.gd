extends Monsters

class_name BaseGlub

@export var projectile_scene : PackedScene

@onready var output : Marker3D = $output
@onready var shoot_timer : Timer = $ShootTimer

func _ready() -> void:
	health = 5
	damage = 5
	speed = 2.5
	range = 14
	xp_amount = 30
	score = 50
	player = GameManager.player

func _physics_process(delta: float) -> void:
	if !is_dead :
		if !player.is_dead:
			if global_position.distance_to(player.global_position)>range:
				enemy_movement()
			look_at_player()
			death()
		else:
			shoot_timer.stop()
			dance()

func shoot() -> void:
	var projectile : GlubProjectile = projectile_scene.instantiate()
	projectile.damage = damage
	projectile.range = range
	projectile.speed = 10
	projectile.pos = output.global_position
	GameManager.original_node.add_child(projectile)
	projectile.global_position = output.global_position

func _on_shoot_timer_timeout() -> void:
	if global_position.distance_to(player.global_position)<=range:
		shoot()
