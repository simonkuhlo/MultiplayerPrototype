extends Node3D
class_name CollectableObject


@export var visuals:Node3D
@export var timer:Timer

@export var factor:float = 0.7
@export var max:float = 0.3

func _physics_process(delta: float) -> void:
	visuals.rotate_y(2 * delta)
	visuals.position.y += clampf(factor * delta, -max, max)
	if abs(visuals.position.y) >= abs(max):
		factor *= -1


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is PlayerCharacter:
		if body.health < body.max_health:
			body.health = body.max_health
			hide()
			timer.start()


func _on_timer_timeout() -> void:
	show()
