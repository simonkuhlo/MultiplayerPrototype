extends Resource
class_name NetworkPlayer

@export var player_name:String = "Stranger"
@export var custom_color:Color = Color("b4bd7e")

const player_name_key:StringName = "name"
const custom_color_key:StringName = "color"

func _init(
			new_player_name:String = player_name,
			new_custom_color:Color = custom_color,
			) -> void:
	player_name = new_player_name
	custom_color = new_custom_color

static func class_from_dict(dict:Dictionary) -> NetworkPlayer:
	var player = NetworkPlayer.new(
		dict[player_name_key],
		Color(dict[custom_color_key])
	)
	return player

func class_to_dict() -> Dictionary:
	var returned_dict = {
		"name" : str(player_name),
		"color" : str(custom_color.to_html())
	}
	return returned_dict
