extends CharacterBody3D
class_name PlayerCharacter

signal health_changed(health_value)
signal item_equipped(item:GameItem)
var controlling_peer:int

@export var inventory:PlayerInventory:
	set(new):
		if inventory:
			inventory.parent_player = null
		inventory = new
		inventory.parent_player = self

@export_group("Stats")
@export var max_health = 5
@onready var health = max_health:
	set(new):
		health = min(new, max_health)
		if health <= 0:
			_on_hp_empty()
		health_changed.emit(health)
@export var speed = 10.0
@export var jump_velocity = 10.0

var gravity = 20.0

@export_group("Setup")
@export var camera_origin:Marker3D
@export var aim_marker:Marker3D
@export var camera:Camera3D
@export var visual_mesh:MeshInstance3D
@export var item_holder:Node3D
@export var audio_listener:AudioListener3D
@export var camrea_ray:RayCast3D

var current_item:GameItem:
	set(new):
		if current_item == new:
			return
		if !item_holder:
			push_error("Player has no set item holder. Item cannot be equipped.")
			return
		if current_item:
			current_item.instance.queue_free()
		current_item = new
		if current_item:
			var instance = current_item.instance
			item_holder.add_child(instance)
		item_equipped.emit(current_item)

func _enter_tree():
	set_multiplayer_authority(int(name))

func _ready():
	if not is_multiplayer_authority(): 
		return
	item_equipped.emit(current_item)
	camera.current = true
	audio_listener.current = true

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

	#if anim_player.current_animation == "shoot":
		#pass
	#elif input_dir != Vector2.ZERO and is_on_floor():
		#anim_player.play("move")
	#else:
		#anim_player.play("idle")
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
	pass
	#if anim_name == "shoot":
		#anim_player.play("idle")
