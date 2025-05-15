extends CanvasLayer
class_name PlayerHUD

var controlled_player:PlayerCharacter:
	set(new):
		if controlled_player:
			_disconnect_entity()
		controlled_player = new
		if controlled_player:
			_connect_entity()

@export var hp_bar:ProgressBar
@export var _item_ui_container:Container
@export var _item_ui_fallback_scene:PackedScene
@export var _hit_sound:AudioStreamPlayer

var current_item:GameItem:
	set(new):
		if current_item == new:
			return
		if current_item:
			if current_item.hud_scene_instance:
				current_item.hud_scene_instance.queue_free()
			if current_item.overlay_scene_instance:
				current_item.overlay_scene_instance.queue_free()
		current_item = new
		if current_item.hud_scene:
			_item_ui_container.add_child(current_item.hud_scene_instance)
		else:
			var fallback_instance:GameItemHUD = _item_ui_fallback_scene.instantiate()
			_item_ui_container.add_child(fallback_instance)
		if current_item.overlay_scene:
			add_child(current_item.overlay_scene_instance)

var current_item_overlay:GameItemHUDOverlay

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	hide()

func _on_visibility_changed():
	if !current_item:
		return
	if current_item.overlay_scene_instance:
		current_item.overlay_scene_instance.visible = visible

func _connect_entity() -> void:
	controlled_player.health_changed.connect(_update_hp_bar)
	controlled_player.item_equipped.connect(_on_item_equipped)
	hp_bar.max_value = controlled_player.max_health
	_update_hp_bar(0)

func _disconnect_entity() -> void:
	controlled_player.health_changed.disconnect(_update_hp_bar)
	controlled_player.item_equipped.disconnect(_on_item_equipped)

func _update_hp_bar(_health:int) -> void:
	hp_bar.value = controlled_player.health

func _on_item_equipped(new_item:GameItem):
	current_item = new_item

func _on_player_hit():
	_hit_sound.play()
