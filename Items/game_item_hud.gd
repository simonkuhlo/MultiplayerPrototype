extends Control
class_name GameItemHUD

var parent_resource:GameItem:
	set(new):
		parent_resource = new
		texture.texture = parent_resource.icon
		name_label.text = parent_resource.item_name

@export var texture:TextureRect
@export var name_label:Label
