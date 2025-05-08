extends Node
class_name BasicGameLogic

@export var Player:PackedScene
@export var connected_peers:Array[int] = []

func start_game(): 
	if multiplayer.is_server():
		for player in connected_peers:
			spawn_player(player)

func spawn_player(peer_id):
	var player:PlayerCharacter = Player.instantiate()
	player.controlling_peer = peer_id
	player.name = str(peer_id)
	var player_spawn = Env.ingame.level_loader.loaded_level.get_player_spawns()[0]
	player_spawn.spawn_object(player, self)
	if player.is_multiplayer_authority():
		Env.ingame.controlled_player.object = player

func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()

func _on_multiplayer_spawner_spawned(node):
	if node.is_multiplayer_authority():
		Env.ingame.controlled_player.object = node

func _pause():
	Env.ui._pause_menu
