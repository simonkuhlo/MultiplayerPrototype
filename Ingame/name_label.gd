extends Label3D

@export var player:CharacterBody3D

func _ready() -> void:
	text = player.name

func _physics_process(delta: float) -> void:
	var target_position:Vector3 = get_viewport().get_camera_3d().global_position
	var direction = (target_position - global_position).normalized()
	var up = Vector3.UP
	if abs(direction.dot(up)) > 0.99:
		# If nearly colinear, pick a different up vector
		up = Vector3.RIGHT  # Or Vector3.RIGHT, depending on your needs
	look_at(target_position, up)
