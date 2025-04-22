extends Node
class_name BasicGameLogic

@export var Player:PackedScene

func start_game(): 
	if multiplayer.is_server():
		for player in Env.ingame.player_manager.connected_peers:
			spawn_player(player)

func spawn_player(peer_id):
	var player:PlayerCharacter = Player.instantiate()
	player.controlling_peer = peer_id
	player.name = str(peer_id)
	var player_spawn = Env.ingame.level_loader.loaded_level.get_player_spawns()[0]
	player_spawn.spawn_object(player, self)
	if player.is_multiplayer_authority():
		player.health_changed.connect(update_health_bar)

func remove_player(peer_id):
	var player = get_node_or_null(str(peer_id))
	if player:
		player.queue_free()

func update_health_bar(health_value):
	pass
	#health_bar.value = health_value

func _on_multiplayer_spawner_spawned(node):
	if node.is_multiplayer_authority():
		node.health_changed.connect(update_health_bar)
