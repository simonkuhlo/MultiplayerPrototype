extends CanvasLayer
class_name PlayerHUD

var controlled_entity:PlayerCharacter:
	set(new):
		if controlled_entity:
			_disconnect_entity()
		controlled_entity = new
		_connect_entity()


@export var hp_bar:ProgressBar

func _connect_entity() -> void:
	controlled_entity.health_changed.connect(_update_progress_bar)
	hp_bar.max_value = controlled_entity.max_health
	_update_progress_bar(0)

func _disconnect_entity() -> void:
	controlled_entity.health_changed.disconnect(_update_progress_bar)

func _update_progress_bar(_health:int) -> void:
	hp_bar.value = controlled_entity.health
