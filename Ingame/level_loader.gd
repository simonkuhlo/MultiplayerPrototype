extends Node
class_name LevelLoader

signal level_loaded()

var loaded_level:GameLevel
var scene_ready:bool = false

func load_level(new_level:GameLevel) -> void:
	for child in get_children():
		child.queue_free()
	add_child(new_level)
	loaded_level = new_level
	Env.ui._clear()
	_on_level_loaded()

func _on_level_loaded() -> void:
	Env.lobby.level_manager.player_loaded.rpc_id(1)
