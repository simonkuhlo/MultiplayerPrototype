extends Node
class_name IngameLogic

signal activated()
signal deactivated()

@export var game_logic:BasicGameLogic
@export var controlled_player:IngamePlayerManager

@export var level_node:Node

@export var is_ingame:bool:
	set(new):
		if new:
			activate()
		else:
			deactivate()
		is_ingame = new

var loaded_level:GameLevel

func activate() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	activated.emit()

func deactivate() -> void:
	deactivated.emit()
	process_mode = Node.PROCESS_MODE_DISABLED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func load_level(new_level:GameLevel) -> void:
	for child in level_node.get_children():
		child.queue_free()
	level_node.add_child(new_level)
	loaded_level = new_level
	Env.ui._clear()
	Env.lobby.level_manager.player_loaded.rpc_id(1)
