extends VBoxContainer

var visualized_players:Dictionary[int, LobbyPlayerVisualizer] = {}

@export var player_visualizer:PackedScene

func _ready() -> void:
	Env.lobby.player_manager.player_connected.connect(_on_player_connect)
	Env.lobby.player_manager.player_list_reset.connect(_on_player_list_reset)
	_on_player_list_reset()

func _on_player_list_reset() -> void:
	for id in Env.lobby.player_manager.connected_players.keys():
		visualize_player(id, Env.lobby.player_manager.connected_players[id])

func _on_player_connect(id:int):
	visualize_player(id, Env.lobby.player_manager.connected_players[id])

func visualize_player(id:int, info:NetworkPlayer):
	update_player(id,info)

func update_player(id:int, info:NetworkPlayer) -> void:
	if !visualized_players.has(id):
		visualized_players[id] = player_visualizer.instantiate()
		add_child(visualized_players[id])
	visualized_players[id].player_to_visualise = info
