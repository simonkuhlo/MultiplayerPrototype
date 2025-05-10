extends CharacterBody3D
class_name PlayerCharacter

signal health_changed(health_value)
signal weapon_switched(new_weapon:WeaponInstance)
var controlling_peer:int



@export_group("Stats")
@export var max_health = 5
@onready var health = 3:
	set(new):
		health = min(new, max_health)
		if health <= 0:
			_on_hp_empty()
		health_changed.emit(health)
@export var speed = 10.0
@export var jump_velocity = 10.0

var gravity = 20.0

@export_group("Setup")
@onready var camera = $Camera3D
@onready var anim_player = $AnimationPlayer
@onready var raycast = $Camera3D/RayCast3D
@export var visual_mesh:MeshInstance3D
@export var gun:WeaponInstance

func _enter_tree():
	set_multiplayer_authority(int(name))

func _ready():
	if not is_multiplayer_authority(): 
		return
	weapon_switched.emit(gun)
	camera.current = true

func _unhandled_input(event):
	if not is_multiplayer_authority(): 
		return
	
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * .005)
		camera.rotate_x(-event.relative.y * .005)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	if not is_multiplayer_authority(): 
		return
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	if anim_player.current_animation == "shoot":
		pass
	elif input_dir != Vector2.ZERO and is_on_floor():
		anim_player.play("move")
	else:
		anim_player.play("idle")
	move_and_slide()

func _on_hp_empty():
	respawn()

func respawn():
	health = max_health
	position = Vector3.ZERO

@rpc("any_peer")
func receive_damage(damage:int):
	health -= damage

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "shoot":
		anim_player.play("idle")
