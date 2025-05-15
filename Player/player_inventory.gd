extends Node
class_name PlayerInventory

@export var parent_player:PlayerCharacter
@export var max_amount:int = 5

@export var items:Array[GameItem] = []

func add_item(new_item: GameItem) -> void:
	if items.size() >= max_amount:
		drop_item(new_item)
		return
	items.append(new_item)

func remove_item(new_item:GameItem) -> void:
	if new_item not in items:
		return
	items.erase(new_item)

func drop_item(new_item:GameItem) -> void:
	if new_item not in items:
		return
	remove_item(new_item)
	#TODO Actually drop the item
