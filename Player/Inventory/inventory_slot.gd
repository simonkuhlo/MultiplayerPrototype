extends Node
class_name InventorySlot

@export var held_item:GameItem
@export var action_bind:StringName

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
