extends BarcodeObject

@export var heal_amount:int

func on_scan(scanning_player:PlayerCharacter) -> void:
	scanning_player.health += heal_amount
