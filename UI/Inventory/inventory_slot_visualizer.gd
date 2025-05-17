extends Control
class_name InventorySlotVisualizer

var slot_to_visualize:PlayerInventorySlot:
	set(new):
		if slot_to_visualize:
			slot_to_visualize.item_changed.disconnect(_on_slot_to_visualize_item_changed)
		slot_to_visualize = new
		if slot_to_visualize:
			slot_to_visualize.item_changed.connect(_on_slot_to_visualize_item_changed)
			if slot_to_visualize.hotkey:
				hotkey_label.text = InputMap.action_get_events(slot_to_visualize.hotkey)[0].as_text().replace(" (Physical)", "")
			if slot_to_visualize.held_item:
				_on_slot_to_visualize_item_changed(slot_to_visualize.held_item)

@export var texture_rect:TextureRect
@export var hotkey_label:Label

func _on_slot_to_visualize_item_changed(new_item:GameItem):
	if new_item:
		if slot_to_visualize.held_item.icon:
			texture_rect.texture = slot_to_visualize.held_item.icon
	else:
		texture_rect.texture = null
