extends CanvasLayer
class_name PlayerHUD

var controlled_player:PlayerCharacter:
	set(new):
		print(new)
		if controlled_player:
			_disconnect_entity()
		controlled_player = new
		if controlled_player:
			_connect_entity()

@export var hp_bar:ProgressBar

func _connect_entity() -> void:
	controlled_player.health_changed.connect(_update_progress_bar)
	hp_bar.max_value = controlled_player.max_health
	_update_progress_bar(0)

func _disconnect_entity() -> void:
	controlled_player.health_changed.disconnect(_update_progress_bar)

func _update_progress_bar(_health:int) -> void:
	hp_bar.value = controlled_player.health
