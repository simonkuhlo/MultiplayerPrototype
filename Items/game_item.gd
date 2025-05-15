extends Resource
class_name GameItem

@export var icon:Texture2D
@export var item_name:StringName = "Unknown Item"
@export var instance_scene:PackedScene
var instance:GameItemInstance:
	get():
		if !instance:
			instance = instance_scene.instantiate()
			instance.parent_resource = self
		return instance

@export var hud_scene:PackedScene
@export var overlay_scene:PackedScene
