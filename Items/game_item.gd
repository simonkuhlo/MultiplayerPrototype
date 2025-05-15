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
var hud_scene_instance:GameItemHUD:
	get():
		if !hud_scene_instance:
			if !hud_scene:
				return
			hud_scene_instance = hud_scene.instantiate()
			hud_scene_instance.parent_resource = self
		return hud_scene_instance
@export var overlay_scene:PackedScene
var overlay_scene_instance:GameItemHUDOverlay:
	get():
		if !overlay_scene_instance:
			if !overlay_scene:
				return
			overlay_scene_instance = overlay_scene.instantiate()
			overlay_scene_instance.parent_resource = self
		return overlay_scene_instance
