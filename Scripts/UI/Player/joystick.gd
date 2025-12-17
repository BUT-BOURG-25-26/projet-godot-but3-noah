extends Node2D

@onready var touch:TouchScreenButton = %TouchBtn
@onready var init_pos:Marker2D = %InitPos

@export var up_input:String = "move_forward"
@export var down_input:String = "move_backward"
@export var left_input:String = "move_left"
@export var right_input:String = "move_right"

var radius = 20

func _draw() -> void:
	var center = Vector2(0, 0)
	var draw_radius = 50
	var start_angle = 0.0 
	var end_angle = 360 
	var color = Color.POWDER_BLUE # Red color
	var width = 10
	draw_arc(center, draw_radius, start_angle, end_angle,120, color, width,true)
	draw_circle(touch.position,60,Color.SKY_BLUE)
	draw_arc(touch.position, 60, start_angle, end_angle,120, Color.STEEL_BLUE, width,true)

func _process(delta: float) -> void:
	queue_redraw()
	var mouse_pos = get_global_mouse_position()
	var touch_pos = init_pos.global_transform.origin
	var distance = touch_pos.distance_to(mouse_pos)
	var mouse_dir = (mouse_pos-touch_pos).normalized()
	if distance > radius:
		mouse_pos = touch_pos + (mouse_dir * radius)
	touch.global_transform.origin = mouse_pos
	if touch.position != init_pos.position:
		var angle = init_pos.get_angle_to(mouse_pos)
		if angle >= -0.5 and angle <= 0.5:
			reset_dir()
			Input.action_press(right_input)
		elif angle >= 0.5 and angle <= 1.0:
			reset_dir()
			Input.action_press(down_input)
			Input.action_press(right_input)
		elif angle >= 1.0 and angle <= 2.1:
			reset_dir()
			Input.action_press(down_input)
		elif angle >= 2.1 and angle <= 2.7:
			reset_dir()
			Input.action_press(down_input)
			Input.action_press(left_input)
		elif angle >= 2.7 and angle <= 3.2:
			reset_dir()
			Input.action_press(left_input)
		elif angle >= -3.2 and angle <= -2.7:
			reset_dir()
			Input.action_press(left_input)
		elif angle >= -2.7 and angle <= -2.1:
			reset_dir()
			Input.action_press(up_input)
			Input.action_press(left_input)
		elif angle >= -2.1 and angle <= -1.0:
			reset_dir()
			Input.action_press(up_input)
		elif angle >= -1.0 and angle <= -0.5:
			reset_dir()
			Input.action_press(up_input)
			Input.action_press(right_input)

func reset_dir():
	Input.action_release(up_input)
	Input.action_release(down_input)
	Input.action_release(left_input)
	Input.action_release(right_input)

func _on_tree_exiting() -> void:
	reset_dir()
