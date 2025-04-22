extends Control

@export var address_entry:LineEdit

func _on_connect_button_pressed() -> void:
	if address_entry.text:
		#TODO validate IP address
		Env.lobby.create_client(address_entry.text)
		Env.lobby_ui.to_lobby()
