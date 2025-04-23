extends Node
class_name IngamePlayerManager

@export var ingame_hud_scene:PlayerHUD

var object:PlayerCharacter:
	set(new):
		if new:
			ingame_hud_scene.controlled_player = new
			ingame_hud_scene.show()
		else:
			ingame_hud_scene.hide()
		object = new
