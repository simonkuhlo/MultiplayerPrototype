extends Resource
class_name NetworkPlayer

@export var player_name:String = "Stranger"
@export var custom_color:Color = Color("b4bd7e")

func _init(
			new_player_name:String = player_name,
			new_custom_color:Color = custom_color,
			) -> void:
	player_name = new_player_name
	custom_color = new_custom_color
