extends VBoxContainer


@export var level_selector_button:PackedScene


func _ready() -> void:
	for level in Env.lobby.level_manager.level_pool.levels:
		var selector:LevelSelectorButton = level_selector_button.instantiate()
		selector.represented_level = level
		selector.level_selected.connect(_on_level_selected)
		add_child(selector)

func _on_level_selected(level:LevelResource):
	Env.lobby.level_manager.select_level(level)
