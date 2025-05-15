extends Node3D
class_name GameItemInstance

var parent_resource:GameItem
var parent_player:PlayerCharacter

@export var aimable:bool = true

var _aiming:bool = false

func _listen_for_input() -> void:
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
			self.global_transform.origin = parent_player.aim_marker.global_transform.origin
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
