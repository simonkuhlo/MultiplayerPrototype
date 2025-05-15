extends GameItemInstance

@export var ray_cast:RayCast3D

func _action_one() -> void:
	var collider = ray_cast.get_collider()
	if collider is BarcodeObject:
		_on_code_read(collider)

func _on_code_read(code:BarcodeObject):
	print("Code Read!")
