extends RigidBody3D
class_name GameItemPickupContainer

var held_item:GameItem:
	set(new):
		if held_item:
			remove_child(held_item.instance)
		held_item = new
		if held_item:
			add_child(held_item.instance)
