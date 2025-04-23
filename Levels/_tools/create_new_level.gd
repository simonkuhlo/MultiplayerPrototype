@tool
extends Node

@export var level_name:String

@export_tool_button("Create new Level") var x = _on_create_button_pressed

@export_group("Settings")
@export_dir var working_folder: String = "res://Levels/Work/":
	set(new_folder):
		_dir = DirAccess.open(working_folder)

var _dir = DirAccess.open(working_folder)

func _on_create_button_pressed() -> void:
	if !validate_name():
		return
	create_environment()
	level_name = ""

func validate_name(name_to_validate:String = level_name) -> bool:
	if !name_to_validate:
		return false
	if _dir.dir_exists(name_to_validate):
		push_error("Dir already exists")
		return false
	return true

func create_environment(env_name:String = level_name) -> void:
	var err = _dir.make_dir(env_name)
	if err == OK:
		print("Folder created successfully!")
		var editor_fs = EditorInterface.get_resource_filesystem()
		editor_fs.scan()
		# Create PackedScene
		var root_node = GameLevel.new()
		root_node.name = env_name
		var player_spawn = PlayerSpawn.new()
		player_spawn.name = "PlayerSpawn"
		root_node.add_child(player_spawn)
		player_spawn.owner = root_node
		var grid_map = GridMap.new()
		grid_map.name = "GridMap"
		root_node.add_child(grid_map)
		grid_map.owner = root_node
		var packed_scene = PackedScene.new()
		packed_scene.resource_name = env_name
		var result = packed_scene.pack(root_node)
		if result != OK:
			push_error("Failed to pack the scene.")
			return
		var error = ResourceSaver.save(packed_scene, working_folder + env_name + "/" + env_name + ".tscn")
		if error != OK:
			push_error("An error occurred while saving the scene to disk.")
		else:
			print("Scene saved successfully!")

	else:
		print("Failed to create folder. Error code: ", err)
