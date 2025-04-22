extends VBoxContainer

@export var preview_image:TextureRect
@export var level_name_label:Label

func _ready() -> void:
	Env.lobby.level_manager.level_selected.connect(_on_level_selected)

func _on_level_selected(new_level:LevelResource) -> void:
	if new_level:
		preview_image.texture = null
		if new_level.preview_image:
			preview_image.texture = new_level.preview_image
		level_name_label.text = new_level.level_name
	else:
		preview_image.texture = null
		level_name_label.text = "NO MAP SELECTED"
