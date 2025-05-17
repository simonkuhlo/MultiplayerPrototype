extends Node
class_name SelectedSlotManager

signal slot_selected(slot:PlayerInventorySlot)
signal item_changed(new_item:GameItem)

@export var slot:PlayerInventorySlot:
	set(new):
		if slot == new:
			return
		if slot:
			slot.item_changed.disconnect(_on_selected_slot_item_changed)
		slot = new
		if slot:
			slot.item_changed.connect(_on_selected_slot_item_changed)
			_on_selected_slot_item_changed(slot.held_item)
		slot_selected.emit(slot)

@export var item:GameItem:
	set(new):
		if item:
			_parent_inventory.parent_player.current_item = null
			item.instance.queue_free()
		item = new
		if item:
			if _parent_inventory.parent_player:
				_parent_inventory.parent_player.current_item = item
		item_changed.emit(item)

var _parent_inventory:PlayerInventory:
	set(new):
		if _parent_inventory:
			_parent_inventory.parent_player_set.disconnect(_on_parent_player_set)
		_parent_inventory = new
		if _parent_inventory:
			_parent_inventory.parent_player_set.connect(_on_parent_player_set)
			if _parent_inventory.parent_player:
				if item:
					_parent_inventory.parent_player.current_item = item

func _on_parent_player_set(player:PlayerCharacter):
	if !player:
		return
	if item:
		_parent_inventory.parent_player.current_item = item

func _on_selected_slot_item_changed(new_item:GameItem):
	item = new_item

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("drop_selected_item"):
		if slot:
			slot.drop_held_item()
