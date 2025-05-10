extends Area3D

func _ready() -> void:
	body_entered.connect(_on_object_entered)

func _on_object_entered(object:Node3D) -> void:
	if object is PlayerCharacter:
		object.respawn()
