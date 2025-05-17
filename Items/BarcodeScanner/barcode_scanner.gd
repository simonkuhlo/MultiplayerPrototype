extends GameItemInstance

@export var ray_cast:RayCast3D
@export var audio_player:AudioStreamPlayer3D

func _action_one() -> void:
	var collider = ray_cast.get_collider()
	if collider is BarcodeObject:
		_on_code_read(collider)

func play_scan_effects():
	audio_player.play()

func _on_code_read(code:BarcodeObject):
	code.on_scan(resource.owning_player)
	play_scan_effects()
