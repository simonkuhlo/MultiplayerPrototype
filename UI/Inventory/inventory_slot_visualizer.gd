extends Control
class_name InventorySlotVisualizer

var item_to_visualize:GameItem:
	set(new):
		item_to_visualize = new
		if item_to_visualize:
			if !item_to_visualize.icon:
				return
			texture_rect.texture = item_to_visualize.icon

var hotkey:String:
	set(new):
		hotkey = new
		if hotkey:
			hotkey_label.text = hotkey

@export var texture_rect:TextureRect
@export var hotkey_label:Label
