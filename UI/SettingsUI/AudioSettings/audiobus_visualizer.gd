extends HBoxContainer
class_name AudioBusSettingsVisualizer

signal cached_value_changed(new_value:float)
var cached_value:float = 0:
	set(new):
		cached_value = new
		cached_value_label.text = str(round(cached_value * 100)/100)
		cached_value_changed.emit(cached_value)

@export var auto_apply:bool

var bus_index:int:
	set(new):
		bus_index = new
		name_label.text = AudioServer.get_bus_name(bus_index)
		var current_volume:float = AudioServer.get_bus_volume_db(bus_index)
		if min_value.min_value > current_volume:
			min_value.min_value = current_volume
			min_value.value = current_volume
		if max_value.max_value < current_volume:
			max_value.max_value = current_volume
			max_value.value = current_volume
		volume_slider.value = current_volume
		cached_value = current_volume
		current_value_label.text = str(volume_slider.value)

@export var name_label:Label
@export var current_value_label:Label
@export var cached_value_label:Label

@export var min_value:SpinBox:
	set(new):
		if min_value:
			min_value.value_changed.disconnect(_on_min_value_changed)
		min_value = new
		if min_value:
			if max_value:
				min_value.max_value = max_value.min_value
			min_value.value_changed.connect(_on_min_value_changed)

@export var max_value:SpinBox:
	set(new):
		if max_value:
			max_value.value_changed.disconnect(_on_max_value_changed)
		max_value = new
		if max_value:
			max_value.min_value = min_value.max_value
			max_value.value_changed.connect(_on_max_value_changed)

@export var volume_slider:HSlider:
	set(new):
		if volume_slider:
			volume_slider.drag_ended.disconnect(_on_volume_slider_dragged)
			volume_slider.value_changed.disconnect(_on_volume_slider_value_changed)
		volume_slider = new
		if volume_slider:
			volume_slider.drag_ended.connect(_on_volume_slider_dragged)
			volume_slider.value_changed.connect(_on_volume_slider_value_changed)
			_on_min_value_changed(min_value.value)
			_on_max_value_changed(max_value.value)

func _on_min_value_changed(new_value:float) -> void:
	if volume_slider.value < new_value:
		volume_slider.value = new_value
	volume_slider.min_value = new_value

func _on_max_value_changed(new_value:float) -> void:
	if volume_slider.value > new_value:
		volume_slider.value = new_value
	volume_slider.max_value = new_value

func _on_volume_slider_value_changed(new_value:float) -> void:
	cached_value = new_value
	if auto_apply:
		apply()

func _on_volume_slider_dragged(value_changed:bool) -> void:
	if value_changed:
		_on_volume_slider_value_changed(volume_slider.value)

func apply() -> void:
	AudioServer.set_bus_volume_db(bus_index, cached_value)
	current_value_label.text = str(cached_value)
