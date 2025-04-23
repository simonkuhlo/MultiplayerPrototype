extends Node
class_name UIController

@export_group("Setup")
@export var _main_menu:Control
@export var _lobby_select:Control
@export var _lobby_screen:Control
@export var _cutomizer:Control
@export var _pause_menu:Control
@export var _settings:Control

func main_menu() -> void:
	_clear()
	_main_menu.show()

func lobby_selector() -> void:
	_clear()
	_lobby_select.show()

func lobby_screen() -> void:
	_clear()
	_lobby_screen.show()

func settings() -> void:
	_clear()
	_settings.show()

func customizer() -> void:
	_clear()
	_cutomizer.show()

func _clear() -> void:
	for child in get_children():
		child.hide()
