extends Node3D
class_name WeaponInstance

signal current_ammo_changed(new_amount:int)
signal max_ammo_changed(new_amount:int)

signal reload_time_changed(new_time:float)

signal hit_something()

signal shooting()
signal reloading()

@export var fire_rate:float = 0.3
@export var damage:int = 1
@export var max_ammo:int = 10:
	set(new):
		max_ammo = new
		max_ammo_changed.emit(max_ammo)
var current_ammo:int = 1:
	set(new):
		current_ammo = clamp(new, 0, max_ammo)
		current_ammo_changed.emit(current_ammo)
@export var reload_amount:int = 1
@export var reload_time:float = 0.1

@export var weapon_icon:Texture2D

enum WeaponState {READY, SHOOTING, RELOADING}
@export var _weapon_state:WeaponState = WeaponState.READY
var _queued_state:WeaponState


@export var _reload_timer:Timer
@export var _cooldown_timer:Timer
@export var _animation_player:AnimationPlayer
@export var _raycast:RayCast3D
@export var _muzzle_flash:GPUParticles3D

func _unhandled_input(event: InputEvent) -> void:
	if !is_multiplayer_authority():
		return
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("reload"):
		reload()

func _on_reload_timer_timeout():
	if _weapon_state == WeaponState.RELOADING:
		current_ammo += reload_amount
		if current_ammo < max_ammo:
			reload()

func shoot():
	if _weapon_state not in [WeaponState.READY, WeaponState.RELOADING]:
		return
	if current_ammo <= 0:
		return
	shooting.emit()
	current_ammo -= 1
	_weapon_state = WeaponState.SHOOTING
	play_shoot_effects.rpc()
	if _raycast.is_colliding():
		var hit_player = _raycast.get_collider()
		hit_player.receive_damage.rpc_id(hit_player.get_multiplayer_authority(), damage)
		hit_something.emit()
	_cooldown_timer.start(fire_rate)
	

func reload():
	if _weapon_state not in [WeaponState.READY, WeaponState.RELOADING]:
		if _weapon_state == WeaponState.SHOOTING:
			_queued_state = WeaponState.RELOADING
		return
	if current_ammo < max_ammo:
		reloading.emit()
		_weapon_state = WeaponState.RELOADING
		_reload_timer.start(reload_time)

func _on_cooldown_timer_timeout():
	_weapon_state = WeaponState.READY
	if _queued_state == WeaponState.RELOADING:
		_queued_state = WeaponState.READY
		reload()

@rpc("call_local")
func play_reload_effects():
	_animation_player.stop()
	_animation_player.play("reload")
	_animation_player.restart()
	_animation_player.emitting = true

@rpc("call_local")
func play_shoot_effects():
	_animation_player.stop()
	_animation_player.play("shoot")
	_muzzle_flash.restart()
	_muzzle_flash.emitting = true
