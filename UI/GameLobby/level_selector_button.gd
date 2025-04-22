extends Button
class_name LevelSelectorButton

signal level_selected(level:LevelResource)

var represented_level:LevelResource:
	set(new_level):
		if new_level:
			represented_level = new_level
			text = new_level.level_name

func _on_pressed() -> void:
	level_selected.emit(represented_level)
