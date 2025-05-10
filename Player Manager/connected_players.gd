extends Node
class_name PlayerManagerConnectedPlayers

var own_player:NetworkPlayer

signal player_connected(player:NetworkPlayer)
signal player_disconnected(player:NetworkPlayer)

var list:Array[NetworkPlayer] = []

func _on_child_entered_tree(node: Node) -> void:
	if node is NetworkPlayer:
		list.append(node)
		if int(node.name) == multiplayer.get_unique_id():
			own_player = node
		player_connected.emit(node)

func _on_child_exiting_tree(node: Node) -> void:
	if node is NetworkPlayer:
		list.erase(node)
		player_disconnected.emit(node)
