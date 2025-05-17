extends Node3D
class_name GameItemInstance

var resource:GameItem

@export var aimable:bool = true

@export_group("Setup")
@export var visual_mesh:MeshInstance3D

var _aiming:bool = false

func _listen_for_input() -> void:
	if !resource.owning_player:
		return
	if !resource.owning_player.is_multiplayer_authority():
		return
	_listen_for_aiming()
	if Input.is_action_just_pressed("item_action_1"):
		_action_one()
	if Input.is_action_just_pressed("item_action_2"):
		_action_two()
	if Input.is_action_just_pressed("item_action_3"):
		_action_three()

func _listen_for_aiming() -> void:
	if aimable:
		if Input.is_action_pressed("aim"):
			self.global_transform.origin = resource.owning_player.aim_marker.global_transform.origin
		else:
			self.position = Vector3.ZERO
	else:
		if Input.is_action_just_pressed("aim"):
			_action_two()

func _action_one() -> void:
	pass

func _action_two() -> void:
	pass

func _action_three() -> void:
	pass

func _physics_process(delta: float) -> void:
	_listen_for_input()
