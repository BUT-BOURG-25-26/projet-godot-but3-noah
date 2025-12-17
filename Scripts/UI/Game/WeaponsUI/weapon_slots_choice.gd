extends Node3D

class_name WeaponChoiceUI

@export var weapons_list_scene : PackedScene
@export var weapon_slot_scene : PackedScene

func _ready() -> void:
	var weapons_scene : Node3D = weapons_list_scene.instantiate()
	add_child(weapons_scene)
	weapons_scene.global_position = Vector3(0, -100, 0)
	var weapons_list = weapons_scene.get_children()
	var j=0
	var k=0
	for i in range(0, weapons_list.size()):
		var weapon : Weapons = weapons_list[i]
		var weapon_slot : WeaponSlot = weapon_slot_scene.instantiate()
		add_child(weapon_slot)
		weapon_slot.init(weapon.name)
		weapon_slot.global_position = Vector3(k*7, 2.5, j*7)
		j+=1
		if (i+1)%3==0:
			j=0
			k+=1
