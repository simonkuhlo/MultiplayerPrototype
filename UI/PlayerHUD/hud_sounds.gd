extends AudioStreamPlayer
class_name HudSounds

@export var library:Dictionary[String, AudioStreamWAV]

func play_hit():
	stream = library["hit"]
	play()
