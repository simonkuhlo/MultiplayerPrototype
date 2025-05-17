extends Control
class_name GameItemHUD

var resource:GameItem:
	set(new):
		resource = new
		texture.texture = resource.icon
		name_label.text = resource.item_name

@export var texture:TextureRect
@export var name_label:Label
