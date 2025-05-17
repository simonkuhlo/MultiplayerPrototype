extends GameItemInstance

func _action_one() -> void:
	var collider = resource.owning_player.camrea_ray.get_collider()
	if collider:
		if collider is GameItemPickupContainer:
			resource.owning_player.inventory.add_item(collider.held_item)
			collider.queue_free()
