extends RigidBody3D
class_name GameItemPickupContainer

@export var held_item:GameItem:
	set(new):
		if held_item:
			remove_child(held_item.instance)
		held_item = new.duplicate(true)
		if held_item:
			add_child(held_item.instance)
