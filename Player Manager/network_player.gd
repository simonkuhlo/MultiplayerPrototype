extends Node
class_name NetworkPlayer

@export var player_name:String = "Missing Name"
@export var unique_id:int
@export var custom_color:Color = Color("c25a7f")

func _enter_tree() -> void:
	set_multiplayer_authority(int(name))
