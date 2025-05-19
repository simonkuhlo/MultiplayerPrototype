extends Node3D
class_name GameItem

@export var item_name:StringName
@export var icon_texture:Texture2D
@export var mesh_scene:PackedScene
@export var hud_scene:Control

var owning_player:PlayerCharacter
