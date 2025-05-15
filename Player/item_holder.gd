extends Node3D
class_name ItemHolder

@export var parent_player:PlayerCharacter:
	set(new):
		parent_player = new
		if current_item:
			current_item.instance.parent_player = parent_player

@export var current_item:GameItem:
	set(new):
		if current_item:
			parent_player.inventory.add_item(current_item)
			for child in get_children():
				child.queue_free()
		current_item = new
		if current_item:
			var instance = new.instance
			instance.parent_player = parent_player
			add_child(instance)
