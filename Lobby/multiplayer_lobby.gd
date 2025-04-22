extends Node
class_name MultiplayerLobby


@export_group("Server")
@export var port:int = 6969
@export var max_players:int = 10


@export_group("Res")
@export var level_manager:MultiplayerLobbyLevelManager
@export var player_manager:MultiplayerLobbyPLayerManager
@export var ui:LobbyUIController

var enet_peer = ENetMultiplayerPeer.new()

func create_server() -> void:
	enet_peer.create_server(port, max_players)
	multiplayer.multiplayer_peer = enet_peer
	player_manager._on_connected_as_server()
	Env.lobby.level_manager.select_level(Env.lobby.level_manager.level_pool.levels[0])

func create_client(remote_adress:String = "localhost") -> void:
	enet_peer.create_client(remote_adress, port)
	multiplayer.multiplayer_peer = enet_peer
	multiplayer.connected_to_server.connect(player_manager._on_connected_as_client)
