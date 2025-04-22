@tool
extends Node3D
class_name GameLevel

var player_spawns:Array[SpawnPoint] = get_player_spawns()

func get_player_spawns() -> Array[SpawnPoint]:
	var spawns:Array[SpawnPoint] = []
	for child in get_children(true):
		if child is SpawnPoint:
			spawns.append(child)
	return spawns

func round_start() -> void:
	pass
