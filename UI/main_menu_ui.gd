extends Control


func _on_host_button_pressed() -> void:
	Env.lobby.create_server()
	Env.ui.lobby_screen()


func _on_join_button_pressed() -> void:
	Env.ui.lobby_selector()
