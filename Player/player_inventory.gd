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

func _input(event: InputEvent) -> void:
	if event.is_action_released("select_item_1"):
		parent_player.current_item = items[0]
	if event.is_action_released("select_item_2"):
		parent_player.current_item = items[1]
	if event.is_action_released("select_item_3"):
		parent_player.current_item = items[2]
	if event.is_action_released("select_item_4"):
		parent_player.current_item = items[3]
	if event.is_action_released("select_item_5"):
		parent_player.current_item = items[4]
