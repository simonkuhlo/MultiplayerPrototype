extends Control
class_name InventoryVisualizer

@export var _inventory_slot_visualizer:PackedScene

@export var container:Container

var inventory:PlayerInventory:
	set(new):
		inventory = new
		for item in inventory.items:
			var instance:InventorySlotVisualizer = _inventory_slot_visualizer.instantiate()
			instance.item_to_visualize = item
			container.add_child(instance)
