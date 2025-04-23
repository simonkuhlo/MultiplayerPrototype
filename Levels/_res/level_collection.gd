extends Resource
class_name LevelCollection

@export var name:StringName = "Standard"
@export var levels:Array[LevelResource] = []

func get_level(name:StringName, version:int) -> LevelResource:
	for level in levels:
		if level.level_name == name and level.version == version:
			return level
	return null
