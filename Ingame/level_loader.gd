extends Node
class_name LevelLoader

signal level_loaded()

var loaded_level:GameLevel

func load_level(new_level:GameLevel) -> void:
	for child in get_children():
		child.queue_free()
	add_child(new_level)
	loaded_level = new_level
	level_loaded.emit()
	Env.lobby.ui.hide_all()
	Env.meta.mouse_mode_control.ingame_mode()
	Env.ingame.game_logic.server_start_game()
