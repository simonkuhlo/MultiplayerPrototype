extends SettingsModule

@export var _bus_visualizer:PackedScene

var visualizers:Array[AudioBusSettingsVisualizer] = []

@export var _instance_holder:Control

func _ready() -> void:
	_get_current_buses()

func _get_current_buses() -> void:
	var bus_count = AudioServer.get_bus_count()
	for i in range(bus_count):
		var instance:AudioBusSettingsVisualizer = _bus_visualizer.instantiate()
		instance.bus_index = i
		_instance_holder.add_child(instance)
		visualizers.append(instance)

func apply() -> void:
	for visualizer in visualizers:
		visualizer.apply()
