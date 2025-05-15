extends Resource
class_name GameItem

@export var icon:Texture2D
@export var item_name:StringName = "Unknown Item"
@export var max_amount:int = 1
@export var instance:PackedScene
@export var hud_scene:PackedScene
@export var overlay_scene:PackedScene
