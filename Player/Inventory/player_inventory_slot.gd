extends Node
class_name PlayerInventorySlot

signal item_changed(new_item:GameItem)

@export var held_item:GameItem:
	set(new):
		if held_item:
			held_item.owning_player = null
			if _parent_inventory.parent_player.current_item == held_item:
				_parent_inventory.parent_player.current_item = null
		held_item = new
		if held_item:
			if _parent_inventory:
				held_item.owning_player = _parent_inventory.parent_player
		item_changed.emit(held_item)
@export var hotkey:StringName
@export var is_locked:bool = false

@export_group("Setup")
@export var game_item_pickup_scene:PackedScene

var _parent_inventory:PlayerInventory:
	set(new):
		if _parent_inventory:
			_parent_inventory.parent_player_set.disconnect(_on_parent_player_switched)
			if held_item:
				held_item.owning_player = null
		_parent_inventory = new
		if _parent_inventory:
			_parent_inventory.parent_player_set.connect(_on_parent_player_switched)
			if held_item:
				_on_parent_player_switched(_parent_inventory.parent_player)

func _on_parent_player_switched(player:PlayerCharacter):
	if held_item:
		held_item.owning_player = player

func _unhandled_key_input(event: InputEvent) -> void:
	if !hotkey:
		return
	if event.is_action_released(hotkey):
		_parent_inventory.selected_slot.slot = self

func drop_held_item() -> void:
	if is_locked:
		return
	if !held_item:
		return
	var pickup_instance:GameItemPickupContainer = game_item_pickup_scene.instantiate()
	pickup_instance.held_item = held_item.duplicate(true)
	held_item = null
	pickup_instance.global_transform = _parent_inventory.parent_player.aim_marker.global_transform
	get_tree().root.add_child(pickup_instance)
