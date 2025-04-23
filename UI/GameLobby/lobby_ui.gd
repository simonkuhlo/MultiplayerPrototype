extends Control

func _on_start_button_pressed() -> void:
	Env.lobby.level_manager.server_load_level()


func _on_customize_button_pressed() -> void:
	Env.ui.customizer()
