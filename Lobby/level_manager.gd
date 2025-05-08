extends Node
class_name MultiplayerLobbyLevelManager

signal level_selected(new_level:LevelResource)
signal all_peers_ready()

@export var level_pool:LevelCollection

@export var awaited_peers:Array[int] = []

@export var selected_level_serialized:Dictionary = {}:
	set(new):
		if !multiplayer.is_server():
			if new.has("name") and new.has("version"):
				var resource:LevelResource = level_pool.get_level(new["name"], new["version"])
				if resource:
					selected_level = resource
				else:
					selected_level = null
			else:
				selected_level = null
		selected_level_serialized = new

var selected_level:LevelResource:
	set(new):
		if multiplayer.is_server():
			selected_level_serialized = {
										"name" : new.level_name,
										"version" : new.version
										}
		selected_level = new
		level_selected.emit(selected_level)

func select_level(new_level:LevelResource):
	if multiplayer.is_server():
		selected_level = new_level

func server_load_level():
	if !multiplayer.is_server():
		return
	if !selected_level:
		push_error("Local level pool does not caontain this level")
		return
	awaited_peers = Env.lobby.player_manager.connected_players.keys()
	load_level.rpc()

@rpc("authority", "call_local", "reliable")
func load_level():
	if !selected_level:
		push_error("Local level pool does not caontain this level")
		return
	Env.ingame.level_loader.load_level(selected_level.level_scene.instantiate())

@rpc("any_peer", "call_local", "reliable")
func player_loaded():
	if !multiplayer.is_server():
		return
	var peer_id = multiplayer.get_remote_sender_id()
	Env.ingame.game_logic.connected_peers.append(peer_id)
	awaited_peers.erase(peer_id)
	if awaited_peers == []:
		Env.ingame.is_ingame = true
		Env.ingame.game_logic.start_game()
