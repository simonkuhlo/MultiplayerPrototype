extends Node
class_name PlayerInventory

var slots:Array[InventorySlot] = []
var selected_slot:InventorySlot:
	set(new):
		if selected_slot:
			_deselect_slot(selected_slot)
		selected_slot = new
		if selected_slot:
			_select_slot(selected_slot)

func _ready() -> void:
	for child in get_children():
		if child is InventorySlot:
			_connect_slot(child)

func add_item(item:GameItem):
	for slot in slots:
		if !slot.held_item:
			slot.held_item = item
			return
	drop_item(item)

func drop_item(item:GameItem):
	pass

func _select_slot(slot:InventorySlot):
	pass

func _deselect_slot(slot:InventorySlot):
	pass

func _connect_slot(slot:InventorySlot):
	slot.slot_selected.connect(_on_slot_selected)
	slot._parent_inventory = self
	slots.append(slot)

func _disconnect_slot(slot:InventorySlot):
	slot.slot_selected.disconnect(_on_slot_selected)
	slot._parent_inventory = null
	slots.erase(slot)

func _on_slot_selected(slot:InventorySlot):
	if slot not in slots:
		return
	selected_slot = slot
