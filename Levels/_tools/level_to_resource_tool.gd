@tool
extends Node

@export var current_scene:PackedScene
@export_tool_button("Convert to resource") var _on_button_pressed = _on_convert_button_pressed

@export_group("Settings")
@export var overwrite: bool = true
@export_dir var output_folder: String = "res://Levels/Levels/"


func _on_convert_button_pressed():
	if !current_scene:
		push_error("Error")
		return
	if !output_folder:
		push_error("Error")
		return
	var resource = scene_to_resource()
	save_level(resource, output_folder)
	current_scene = null

func validate_packed_scene(level_scene:PackedScene = current_scene) -> bool:
	var test_instance = level_scene.instantiate()
	# do validity check on test instance
	# check if PackedScene contains a GameLevel as Root Node
	if test_instance is not GameLevel:
		push_error("Trying to convert a Scene that is not GameLevel to LevelResource")
		return false
	var validated_instance:GameLevel = test_instance
	# check if there are enough registered player spawns on the map
	if validated_instance.get_player_spawns().size() < 0:
		push_error("Not enough player spawns on this map!")
		return false
	return true
	


func scene_to_resource(
						level_scene:PackedScene = current_scene
						) -> LevelResource:
	if !validate_packed_scene(level_scene):
		push_error("Level scene not valid.")
		return
	var instance = level_scene.instantiate()
	var resource:LevelResource = LevelResource.new()
	resource.level_name = instance.name
	resource.level_scene = level_scene
	resource.max_players = instance.get_player_spawns().size()
	return resource

func save_level(level:LevelResource, path:String) -> void:
	if overwrite:
		#delete old file
		pass
	ResourceSaver.save(level, path + level.level_name + ".tres")
