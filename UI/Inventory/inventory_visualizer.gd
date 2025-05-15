extends Control
class_name InventoryVisualizer

@export var _inventory_slot_visualizer:PackedScene

@export var container:Container

var inventory:PlayerInventory:
	set(new):
		inventory = new
		var index:int = 1
		for item in inventory.items:
			var instance:InventorySlotVisualizer = _inventory_slot_visualizer.instantiate()
			if index <= 5:
				instance.hotkey = str(index)
				index += 1
			instance.item_to_visualize = item
			container.add_child(instance)
