extends Node

@export var lobby:MultiplayerLobby
@export var ingame:IngameLogic
@export var ui:UIController


func _ready() -> void:
	ui.main_menu()
