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
		else:
			self.velocity = Vector2(0,0)
		
		move_and_slide()

		networked_data.sync_position = position
		networked_data.sync_crosshair_postion = $Crosshair.position

		# Set camera position
		if input.aim_point.length() > input.CONTROLLER_CROSSHAIR_DIST:
			$Camera.position = input.CONTROLLER_CROSSHAIR_DIST * self.aim_point.normalized()
		else:
			#$Camera.position = Vector2(0, 0)
			$Camera.position = input.aim_point

		animate()
		
	else:
		self.position = networked_data.sync_position
		$Crosshair.position = networked_data.sync_crosshair_postion
	


func take_damage(damage):
	health -= damage
	if health <= 0:
		_die()

func animate():
	$PlayerSprite.flip_h = input.walk_direction.x < 0
	
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
