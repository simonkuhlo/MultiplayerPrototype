extends Control

@export var name_line:LineEdit
@export var color_select:ColorPickerButton


func _on_exit_pressed() -> void:
	Env.lobby.player_manager.own_info.player_name = name_line.text
	Env.lobby.player_manager.own_info.custom_color = color_select.color
	hide()

func _on_visibility_changed() -> void:
	if !visible:
		return
	name_line.text = Env.lobby.player_manager.own_info.player_name
	color_select.color = Env.lobby.player_manager.own_info.custom_color
	
