extends VBoxContainer

var visualized_players:Dictionary[int, LobbyPlayerVisualizer] = {}

@export var player_visualizer:PackedScene

func _ready() -> void:
	for player in Env.lobby.player_manager.connected_players.list:
		create_player_visualizer(player)
	Env.lobby.player_manager.connected_players.player_connected.connect(create_player_visualizer)

func create_player_visualizer(player:NetworkPlayer):
	var instance:LobbyPlayerVisualizer = player_visualizer.instantiate()
	instance.player_to_visualise = player
	add_child(instance)

func remove_player_visualizer(player:NetworkPlayer):
	pass
