extends Control
class_name InventorySlotVisualizer

var item_to_visualize:GameItem:
	set(new):
		item_to_visualize = new
		if item_to_visualize:
			if !item_to_visualize.icon:
				return
			texture_rect.texture = item_to_visualize.icon

@export var texture_rect:TextureRect
