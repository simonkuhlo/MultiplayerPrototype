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

var current_weapon:WeaponInstance:
	set(new):
		if current_weapon:
			current_weapon.current_ammo_changed.disconnect(_on_current_weapon_ammo_changed)
			current_weapon.max_ammo_changed.disconnect(_on_current_weapon_max_ammo_changed)
		current_weapon = new
		if !current_weapon:
			return
		current_weapon.current_ammo_changed.connect(_on_current_weapon_ammo_changed)
		current_weapon.max_ammo_changed.connect(_on_current_weapon_max_ammo_changed)
		current_weapon.hit_something.connect(_on_player_hit)
		weapon_icon.texture = current_weapon.weapon_icon
		_on_current_weapon_ammo_changed(current_weapon.current_ammo)
		max_ammo_label.text = str(current_weapon.max_ammo)
		_name_label.text = current_weapon.name
		_reload_progress_bar.timer = current_weapon._reload_timer
		_reload_progress_bar.max_value = current_weapon.reload_time
		_shoot_progress_bar.timer = current_weapon._cooldown_timer
		_shoot_progress_bar.max_value = current_weapon.fire_rate

@export var hp_bar:ProgressBar
@export var current_ammo_label:Label
@export var max_ammo_label:Label
@export var weapon_icon:TextureRect
@export var _name_label:Label
@export var _reload_progress_bar:TimedProgressBar
@export var _shoot_progress_bar:TimedProgressBar
@export var _hit_sound:AudioStreamPlayer

func _ready() -> void:
	hide()

func _connect_entity() -> void:
	controlled_player.health_changed.connect(_update_hp_bar)
	controlled_player.weapon_switched.connect(_on_weapon_switched)
	if controlled_player.gun:
		_on_weapon_switched(controlled_player.gun)
	hp_bar.max_value = controlled_player.max_health
	_update_hp_bar(0)

func _disconnect_entity() -> void:
	controlled_player.health_changed.disconnect(_update_hp_bar)

func _update_hp_bar(_health:int) -> void:
	hp_bar.value = controlled_player.health

func _on_weapon_switched(new_weapon:WeaponInstance):
	current_weapon = new_weapon

func _on_current_weapon_ammo_changed(new_amount:int):
	current_ammo_label.text = str(new_amount)
	if new_amount <= (current_weapon.max_ammo / 3):
		current_ammo_label.add_theme_color_override("font_color", Color(1, 1, 0, 1))
	else:
		current_ammo_label.add_theme_color_override("font_color", Color(1, 1, 1, 1))

func _on_current_weapon_max_ammo_changed(new_amount:int):
	max_ammo_label.text = str(new_amount)

func _on_player_hit():
	_hit_sound.play()
