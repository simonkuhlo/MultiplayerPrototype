extends Node
class_name PlayerManagerConnectedPlayers

signal player_connected(player:NetworkPlayer)
signal player_disconnected(player:NetworkPlayer)

var list:Array[NetworkPlayer] = []

func _on_child_entered_tree(node: Node) -> void:
	if node is NetworkPlayer:
		list.append(node)
		player_connected.emit(node)

func _on_child_exiting_tree(node: Node) -> void:
	if node is NetworkPlayer:
		list.erase(node)
		player_disconnected.emit(node)
