extends Node

@export var lobby:MultiplayerLobby
@export var lobby_ui:LobbyUIController
@export var level_loader:LevelLoader

func _ready() -> void:
	lobby_ui.to_main_menu()
