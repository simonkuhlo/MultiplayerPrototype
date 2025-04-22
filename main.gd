extends Node

@export var lobby:MultiplayerLobby
@export var ingame:IngameLogic
@export var meta:GameMetaScripts


func _ready() -> void:
	lobby.ui.to_main_menu()
