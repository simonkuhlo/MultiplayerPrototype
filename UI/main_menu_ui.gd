extends Control


func _on_host_button_pressed() -> void:
	Env.lobby.create_server()
	Env.lobby.ui.to_lobby()


func _on_join_button_pressed() -> void:
	Env.lobby.ui.to_lobby_selector()
