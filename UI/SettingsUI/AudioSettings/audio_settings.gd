extends Control

@export var _bus_visualizer:PackedScene

func _ready() -> void:
	_get_current_buses()

func _get_current_buses() -> void:
	var bus_count = AudioServer.get_bus_count()
	for i in range(bus_count):
		var instance:AudioBusSettingsVisualizer = _bus_visualizer.instantiate()
		instance.bus_index = i
		add_child(instance)
