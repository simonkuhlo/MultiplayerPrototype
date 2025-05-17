extends Control
class_name InventoryVisualizer

@export_group("Setup")
@export var _inventory_slot_visualizer:PackedScene
@export var container:Container

var visualized_slots:Dictionary[PlayerInventorySlot, InventorySlotVisualizer] = {}

var _inventory:PlayerInventory:
	set(new):
		if _inventory:
			_inventory.slot_added.disconnect(_on_slot_added)
			_inventory.slot_removed.disconnect(_on_slot_removed)
		_inventory = new
		if _inventory:
			_inventory.slot_added.connect(_on_slot_added)
			_inventory.slot_removed.connect(_on_slot_removed)
			_visualize_inventory(_inventory)

func _visualize_inventory(inventory:PlayerInventory):
	for slot in inventory.slots:
		_on_slot_added(slot)

func _on_slot_added(slot:PlayerInventorySlot):
	var instance:InventorySlotVisualizer = _inventory_slot_visualizer.instantiate()
	instance.slot_to_visualize = slot
	container.add_child(instance)
	visualized_slots[slot] = instance

func _on_slot_removed(slot:PlayerInventorySlot):
	pass
