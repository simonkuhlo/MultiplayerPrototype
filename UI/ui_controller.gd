extends Node
class_name UIController

@export_group("Setup")
@export var _main_menu:Control
@export var _lobby_select:Control
@export var _lobby_screen:Control
@export var _cutomizer:Window
@export var _settings:Window

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
	_settings.show()

func customizer() -> void:
	_cutomizer.show()

func _clear() -> void:
	for child in get_children():
		child.hide()
