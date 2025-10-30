extends Control


@export var pistol_scene: PackedScene
@export var rifle_scene: PackedScene
@export var shotgun_scene: PackedScene
@export var sniper_scene: PackedScene

@onready var pistol_button : Button = $PistolButton
@onready var rifle_button : Button = $RifleButton
@onready var sniper_button : Button = $SniperButton
@onready var shotgun_button : Button = $ShotgunButton

var pistol : Pistol
var rifle : Rifle
var shotgun : Shotgun
var sniper : Sniper

func _ready() -> void:
	pistol_button.pressed.connect(choose_pistol)
	rifle_button.pressed.connect(choose_rifle)
	sniper_button.pressed.connect(choose_sniper)
	shotgun_button.pressed.connect(choose_shotgun)

func choose_pistol():
	pistol = pistol_scene.instantiate()
	GameManager.weapon = pistol
	GameManager.start()

func choose_rifle():
	rifle = rifle_scene.instantiate()
	GameManager.weapon = rifle
	GameManager.start()

func choose_sniper():
	sniper = sniper_scene.instantiate()
	GameManager.weapon = sniper
	GameManager.start()

func choose_shotgun():
	shotgun = shotgun_scene.instantiate()
	GameManager.weapon = shotgun
	GameManager.start()
