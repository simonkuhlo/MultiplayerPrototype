extends Button

func _ready() -> void:
	if !multiplayer.is_server():
		disabled = true
