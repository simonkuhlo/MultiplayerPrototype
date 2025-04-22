extends Node
class_name MultiplayerLobbyPLayerManager

signal player_connected(id:int)
signal player_list_reset()
signal player_disconnected(id:int)

@export var own_info:NetworkPlayer = NetworkPlayer.new()

var connected_players:Dictionary[int, NetworkPlayer] = {}

func _on_connected_as_client():
	connect_player.rpc_id(1, own_info.class_to_dict())

func _on_connected_as_server():
	multiplayer.peer_disconnected.connect(disconnect_player)
	connect_player(own_info.class_to_dict())

@rpc("any_peer", "call_local", "reliable")
func connect_player(player_info:Dictionary):
	var peer_id = multiplayer.get_remote_sender_id()
	connected_players[peer_id] = NetworkPlayer.class_from_dict(player_info)
	remote_player_connected.rpc(peer_id, player_info)
	var player_dict = {}
	for player in connected_players.keys():
		player_dict[player] = connected_players[player].class_to_dict()
	sync_connected_players.rpc_id(peer_id, player_dict)
	player_connected.emit(peer_id)

@rpc("authority", "call_remote", "reliable")
func remote_player_connected(peer_id:int, player_info:Dictionary):
	connected_players[peer_id] = NetworkPlayer.class_from_dict(player_info)
	player_connected.emit(peer_id)

@rpc("authority", "call_remote", "reliable")
func sync_connected_players(player_dict:Dictionary):
	connected_players = {}
	for player in player_dict.keys():
		connected_players[player] = NetworkPlayer.class_from_dict(player_dict[player])
		player_list_reset.emit()

func disconnect_player(peer_id):
	connected_players.erase(peer_id)
	player_disconnected.emit(peer_id)
	remote_player_disconnected.rpc(peer_id)

@rpc("authority", "call_remote", "reliable")
func remote_player_disconnected(peer_id:int):
	connected_players.erase(peer_id)
	player_disconnected.emit(peer_id)
