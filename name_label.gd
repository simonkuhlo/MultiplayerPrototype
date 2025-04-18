extends Label3D

@export var player:CharacterBody3D

func _ready() -> void:
	text = player.name

func _physics_process(delta: float) -> void:
	look_at(get_viewport().get_camera_3d().global_position, Vector3.UP, true)
