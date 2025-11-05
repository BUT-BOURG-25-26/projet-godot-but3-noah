extends Control

class_name StatsPanel

@onready var health_label : Label = $health_label
@onready var damage_label : Label = $damage_label
@onready var attack_speed_label : Label = $attack_speed_label
@onready var speed_label : Label = $speed_label
@onready var range_label : Label = $range_label
@onready var xp_label : Label = $xp_label

var player : Player

func init() -> void:
	player = GameManager.player

func update() -> void:
	health_label.text = "Health : "+str(player.health)+"/"+str(player.max_health)
	damage_label.text = "Damage : "+str(player.attack_damage)
	attack_speed_label.text = "Attack Speed : "+str(player.attack_speed)
	speed_label.text = "Speed : "+str(player.movement_speed)
	range_label.text = "Range : "+str(player.range)
	xp_label.text = "XP : "+str(player.xp)+"/"+str(player.level_xp_amount)
