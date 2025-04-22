extends Marker3D
class_name SpawnPoint

@export var active:bool = true
@export var spawn_cooldown:float

var timer = Timer.new()

func _ready() -> void:
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func spawn_object(object_to_spawn:Node, parent:Node = get_tree().root) -> void:
	if active:
		object_to_spawn.global_transform = self.global_transform
		Env.add_child(object_to_spawn)
		if spawn_cooldown:
			active = false
			timer.start(spawn_cooldown)

func _on_timer_timeout() -> void:
	active = true
