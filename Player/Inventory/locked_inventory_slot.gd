extends InventorySlot
class_name LockedInventorySlot

@export var item_scene:PackedScene:
	set(new):
		item_scene = new
		held_item = item_scene.instantiate()

func drop_item() -> void:
	return
