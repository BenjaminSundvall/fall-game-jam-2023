extends CharacterBody2D

@export var player_client_id := 1
@export var health = 100
@export var speed = 800


var paused

@onready var input = $"Input Handler"
@onready var networked_data = $NetworkData

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
	if player_client_id == multiplayer.get_unique_id():
		if !self.paused:
			# Movement
			self.velocity = self.speed * input.walk_direction
			# Aim
			$Crosshair.position = input.aim_point
			$Camera.position = input.aim_point
			var weapon = $Weapon 
			if weapon:
				weapon.weapon_vector = input.aim_point
		else:
			self.velocity = Vector2(0,0)
		
		move_and_slide()
		
		networked_data.sync_position = position
		networked_data.sync_crosshair_postion = $Crosshair.position
		
		animate()
		
	else:
		self.position = networked_data.sync_position
		$Crosshair.position = networked_data.sync_crosshair_postion
		$Weapon.weapon_vector = networked_data.sync_crosshair_postion


func take_damage(damage):
	health -= damage
	if health <= 0:
		_die()

func animate():
	$PlayerSprite.flip_h = input.walk_direction.x < 0
	
	if $Weapon and $Weapon/Sprite:
		if input.aim_point.x < 0:
			$Weapon/Sprite.flip_h = true
			$Weapon/Sprite.position = Vector2(40, 0)
		elif input.aim_point.x > 0:
			$Weapon/Sprite.flip_h = false
			$Weapon/Sprite.position = Vector2(-40, 0)

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
		get_node("Weapon").attack(input.aim_point)

func _on_pressed_dodge():
	#print_debug("Dodge")
	pass

func _on_pressed_interact():
	#print_debug("Interact")
	pass
