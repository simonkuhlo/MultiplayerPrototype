extends Node
class_name MultiplayerLobbyLevelManager

signal level_selected(new_level:LevelResource)

@export var level_pool:LevelCollection
@export var default_level:LevelResource

var selected_level:LevelResource

func server_select_level(new_level:LevelResource):
	if multiplayer.is_server():
		select_level.rpc(new_level.level_name, new_level.version)

func server_load_level():
	if !selected_level:
		return
	if !multiplayer.is_server():
		return
	load_level.rpc(selected_level.level_name, selected_level.version)

@rpc("authority", "call_local", "reliable")
func select_level(level_name:String, level_version:int):
	var level:LevelResource = level_pool.get_level(level_name, level_version)
	if !level:
		push_error("Local level pool does not caontain this level")
	selected_level = level
	level_selected.emit(selected_level)

@rpc("authority", "call_local", "reliable")
func load_level(level_name:String, level_version:int):
	var level:LevelResource = level_pool.get_level(level_name, level_version)
	if !level:
		push_error("Local level pool does not caontain this level")
	Env.ingame.level_loader.load_level(level.level_scene.instantiate())
