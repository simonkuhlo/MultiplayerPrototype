extends Button

@export var test_item:GameItem

func _ready() -> void:
	pressed.connect(_on_button_pressed)
	
func _on_button_pressed() -> void:
	Env.ingame.controlled_player.object.current_item = test_item
