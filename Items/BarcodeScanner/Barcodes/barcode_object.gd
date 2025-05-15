extends StaticBody3D
class_name BarcodeObject

@export var short_code:StringName
@export var code:String

@export var _label:Label3D

func _ready() -> void:
	if short_code:
		_label.text = short_code

func on_scan(scanning_player:PlayerCharacter) -> void:
	pass
