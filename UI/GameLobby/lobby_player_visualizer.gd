extends Control
class_name LobbyPlayerVisualizer

var player_to_visualise:NetworkPlayer:
	set(new_player_to_visualise):
		if new_player_to_visualise:
			player_to_visualise = new_player_to_visualise
			player_to_visualise.player_updated.connect(update)
			update()

@export var _color_rect:ColorRect
@export var _name_label:Label

func _ready() -> void:
	update()

func update() -> void:
	if player_to_visualise:
		_color_rect.color = player_to_visualise.custom_color
		_name_label.text = player_to_visualise.player_name
