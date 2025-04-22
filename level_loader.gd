extends Node
class_name LevelLoader

signal level_loaded()

func load_level(new_level:GameLevel) -> void:
	for child in get_children():
		child.queue_free()
	add_child(new_level)
	level_loaded.emit()
