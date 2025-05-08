extends Node
class_name NetworkPlayer

signal player_updated()

@export var player_name:String = "Missing Name":
	set(new):
		player_name = new
		player_updated.emit()
@export var unique_id:int:
	set(new):
		unique_id = new
		player_updated.emit()
@export var custom_color:Color = Color("c25a7f"):
	set(new):
		custom_color = new
		player_updated.emit()

func _enter_tree() -> void:
	set_multiplayer_authority(int(name))
