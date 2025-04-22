extends Node

var mouse_modes = [Input.MOUSE_MODE_VISIBLE, Input.MOUSE_MODE_CAPTURED]
var current_index:int = 0:
	set(new_index):
		var count = mouse_modes.size()
		new_index = ((new_index % count) + count) % count
		current_index = new_index

func _unhandled_input(event):
	if Input.is_action_just_pressed("next_mouse_mode"):
		next_mouse_mode()

func next_mouse_mode():
	current_index += 1
	Input.mouse_mode = mouse_modes[current_index]
