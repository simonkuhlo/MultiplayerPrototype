extends Node
class_name LobbyUIController

@export var lobby:Control
@export var lobby_selector:Control
@export var lobby_main_menu:Control

func to_lobby_selector() -> void:
	hide_all()
	lobby_selector.show()

func to_lobby() -> void:
	hide_all()
	lobby.show()

func to_main_menu() -> void:
	hide_all()
	lobby_main_menu.show()

func hide_all() -> void:
	for child in get_children():
		child.hide()
