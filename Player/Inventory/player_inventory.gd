extends Node
class_name PlayerInventory

signal item_added(item:GameItem)
signal item_removed(item:GameItem)

signal slot_added(slot:PlayerInventorySlot)
signal slot_removed(slot:PlayerInventorySlot)

signal parent_player_set(player:PlayerCharacter)

var slots:Array[PlayerInventorySlot] = []

@export_group("Setup")
@export var game_item_pickup_scene:PackedScene
@export var _slots_parent_node:Node:
	set(new):
		for slot in slots:
			_remove_slot(slot)
		_slots_parent_node = new
		if _slots_parent_node:
			for child in _slots_parent_node.get_children():
				if child is PlayerInventorySlot:
					_add_slot(child)
@export var selected_slot:SelectedSlotManager:
	set(new):
		if selected_slot:
			selected_slot._parent_inventory = null
		selected_slot = new
		if selected_slot:
			selected_slot._parent_inventory = self

var parent_player:PlayerCharacter:
	set(new):
		parent_player = new
		parent_player_set.emit(parent_player)


func _ready() -> void:
	pass

func _get_free_slot() -> PlayerInventorySlot:
	for slot in slots:
		if !slot.held_item:
			return slot
	return

func _add_slot(slot:PlayerInventorySlot) -> void:
	slot._parent_inventory = self
	slots.append(slot)

func _remove_slot(slot:PlayerInventorySlot) -> void:
	if slot not in slots:
		return
	slot._parent_inventory = null
	slots.erase(slot)

func add_item(new_item: GameItem) -> void:
	var slot:PlayerInventorySlot = _get_free_slot()
	if !slot:
		var pickup_instance:GameItemPickupContainer = game_item_pickup_scene.instantiate()
		pickup_instance.held_item = new_item
		pickup_instance.global_transform = parent_player.aim_marker.global_transform
		get_tree().root.add_child(pickup_instance)
	slot.held_item = new_item
	item_added.emit(new_item)

func remove_item(new_item:GameItem) -> bool:
	if !new_item:
		return false
	for slot in slots:
		if slot.held_item == new_item:
			slot.held_item = null
			item_removed.emit(new_item)
			return true
	return false
