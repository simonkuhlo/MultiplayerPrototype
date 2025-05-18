extends Node
class_name InventorySlot

signal slot_selected(emitter:InventorySlot)

var held_item:GameItem:
	set(new):
		if held_item:
			pass
		held_item = new
		if held_item:
			pass
@export var hotkey:StringName

var _parent_inventory:PlayerInventory:
	set(new):
		if _parent_inventory:
			pass
		_parent_inventory = new
		if _parent_inventory:
			pass

func drop_item() -> void:
	if held_item:
		pass

func _unhandled_key_input(event: InputEvent) -> void:
	if !hotkey:
		return
	if event.is_action_released(hotkey):
		slot_selected.emit(self)
