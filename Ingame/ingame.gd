extends Node
class_name IngameLogic

@export var game_logic:BasicGameLogic
@export var level_loader:LevelLoader
@export var controlled_player:IngamePlayerManager

@export var pause_menu:Node

@export var is_ingame:bool:
	set(new):
		if new:
			activate()
		else:
			deactivate()
		is_ingame = new

func activate() -> void:
	pause_menu.process_mode = Node.PROCESS_MODE_INHERIT
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	controlled_player.ingame_hud_scene.show()

func deactivate() -> void:
	pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	controlled_player.ingame_hud_scene.hide()
