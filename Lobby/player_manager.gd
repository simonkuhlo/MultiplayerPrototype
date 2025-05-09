extends Node
class_name MultiplayerLobbyPLayerManager

@export var player_scene:PackedScene
@export var connected_players:PlayerManagerConnectedPlayers

func connect_player(id:int):
	if !multiplayer.is_server():
		return
	var instance:NetworkPlayer = player_scene.instantiate()
	instance.name = str(id)
	connected_players.add_child(instance)

func disconnect_player(id:int):
	if !multiplayer.is_server():
		return
	for child in connected_players.get_children():
		child.queue_free()
