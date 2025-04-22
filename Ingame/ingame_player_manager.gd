extends Node
class_name IngamePlayerManager

@export var connected_peers:Array[int] = []
var own_player:PlayerCharacter:
	set(new):
		own_player = new
		Env.ingame.hud.controlled_entity = own_player
