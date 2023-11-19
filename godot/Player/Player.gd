extends CharacterBody2D

@export var player_client_id := 1
@export var health = 100
@export var speed = 800


var paused

@onready var input = $"Input Handler"
@onready var networked_data = $NetworkData

const CAMERA_LOOKAHEAD = 360

# Called when the node enters the scene tree for the first time.
func _ready():
	self.paused = false

@rpc("reliable", "call_local")
func load(id, where, name, nameplate):
	
	networked_data.sync_position = where
	position = where

	networked_data.sync_crosshair_postion = Vector2.ZERO
	$Crosshair.position = Vector2.ZERO

	networked_data.sync_client_id = id
	player_client_id = id
	set_multiplayer_authority(id)
	if id == multiplayer.get_unique_id():
		$Camera.make_current()

#	self.name = "Player " + name 
	$Label.visible = nameplate
	$Label.text = name


@rpc("reliable")
func set_id(id):
	player_client_id = id


func physics_update():	
	if player_client_id != multiplayer.get_unique_id():
		self.position = networked_data.sync_position
		$Crosshair.position = networked_data.sync_crosshair_postion
		$Weapon.weapon_vector = networked_data.sync_crosshair_postion
		return
	
	if !self.paused:
		# Movement
		self.velocity = self.speed * input.walk_direction
		
		# Aim
		$Crosshair.position = input.aim_point
		var weapon = $Weapon 
		if weapon:
			weapon.weapon_vector = input.aim_point
			
		# Set camera position
		if input.input_mode == input.InputMode.CONTROLLER:
			$Camera.position = 0.7 * CAMERA_LOOKAHEAD * input.aim_point.normalized()
		elif input.input_mode == input.InputMode.KEYBOARD:
			var viewport = get_viewport()
			var mouse_pos = 2 * (viewport.get_mouse_position() / viewport.get_visible_rect().size - Vector2(0.5, 0.5))
			$Camera.position = CAMERA_LOOKAHEAD * mouse_pos
	else:
		self.velocity = Vector2(0,0)
	
	move_and_slide()
	
	networked_data.sync_position = position
	networked_data.sync_crosshair_postion = $Crosshair.position
	
	animate()


func take_damage(damage):
	health -= damage
	if health <= 0:
		_die()

func animate():
	$PlayerSprite.flip_h = input.walk_direction.x < 0
	
	var weapon = $Weapon
	if weapon:
		var weapon_sprite = weapon.get_node_or_null("Sprite")	
		if weapon_sprite:
			if input.aim_point.x < 0:
				weapon_sprite.flip_h = true
				weapon_sprite.position = Vector2(40, 0)
			elif input.aim_point.x > 0:
				weapon_sprite.flip_h = false
				weapon_sprite.position = Vector2(-40, 0)

	if input.walk_direction:
		$PlayerSprite.play("player_move")
	else:
		$PlayerSprite.play("player_idle")

func _die():
	#code for dying
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	physics_update()

# ===============================================
#    Weapons
# ===============================================

func add_weapon(weapon_scene):
	_sync_add_weapon.rpc(weapon_scene.get_path())

@rpc("reliable", "call_local")
func _sync_add_weapon(weapon_scene_filename):
	var weapon = load(weapon_scene_filename).instantiate()
	weapon.name = "Weapon"
	
	# Remove previous weapon
	var prev_weapon = get_node("Weapon")
	if prev_weapon:
		remove_child(prev_weapon)
		prev_weapon.queue_free()

	weapon.weapon_vector = Vector2.UP
	
	add_child(weapon)



# ===============================================
#    On events
# ===============================================

func _on_pressed_attack():
	if player_client_id == multiplayer.get_unique_id():
	#print_debug("Attack")
		get_node("Weapon").attack_pressed(input.aim_point)

func _on_released_attack():
	if player_client_id == multiplayer.get_unique_id():
		get_node("Weapon").attack_released(input.aim_point)
	pass # Replace with function body.


func _on_pressed_dodge():
	#print_debug("Dodge")
	pass

func _on_pressed_interact():
	#print_debug("Interact")
	pass
