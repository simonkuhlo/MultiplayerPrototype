extends Node
class_name IngameLogic

@export var game_logic:BasicGameLogic
@export var level_loader:LevelLoader
@export var controlled_player:IngamePlayerManager

@export var pause_menu:Node

var is_ingame:bool = false

func activate() -> void:
	pause_menu.process_mode = Node.PROCESS_MODE_INHERIT
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	controlled_player.ingame_hud_scene.show()
	is_ingame = true

func deactivate() -> void:
	pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	controlled_player.ingame_hud_scene.hide()
	is_ingame = false
