extends Node

@export var ui:CanvasLayer
var paused:bool = _paused
var _paused:bool = false:
	set(new):
		if new:
			pause()
		else:
			resume()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_paused = !paused

func pause():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	Env.ingame.controlled_player.ingame_hud_scene.hide()
	ui.show()
	paused = true

func resume():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Env.ingame.controlled_player.ingame_hud_scene.show()
	ui.hide()
	paused = false
