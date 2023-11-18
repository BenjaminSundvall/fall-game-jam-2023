extends CharacterBody2D

enum InputMode {KEYBOARD, CONTROLLER}

@export var health = 10000
@export var speed = 800
@export var input_mode = InputMode.KEYBOARD

const CONTROLLER_CROSSHAIR_DIST = 200

var aim_point = Vector2(CONTROLLER_CROSSHAIR_DIST, 0)
var movement_input_vector = Vector2(0, 0)
var aim_input_vector = Vector2(0, 0)
var paused

func handle_input():
	if !self.paused:
		self.movement_input_vector = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
		self.aim_input_vector = Input.get_vector("AimLeft", "AimRight", "AimUp", "AimDown")

		# Movement
		self.velocity = self.speed * self.movement_input_vector

		# Aim
		if self.input_mode == InputMode.CONTROLLER and aim_input_vector:
			self.aim_point = CONTROLLER_CROSSHAIR_DIST * aim_input_vector.normalized()
		elif self.input_mode == InputMode.KEYBOARD:
			self.aim_point = get_global_mouse_position() - position
		$Crosshair.position = self.aim_point
		$Camera.position = self.aim_point
		
		# Interact
		if Input.is_action_just_pressed("Interact"):
			print("Interact")

		# Dodge
		if Input.is_action_just_pressed("Dodge"):
			print("Dodge")

		# Attacking
		if Input.is_action_just_pressed("Attack"):
			print("Attack")
			get_node("Weapon").attack(aim_point)
	else:
		self.velocity = Vector2(0,0)


func take_damage(damage):
	health -= damage
	if health <= 0:
		_die()

func animate():
	if self.movement_input_vector.x < 0:
		$PlayerSprite.flip_h = true
	elif self.movement_input_vector.x > 0:
		$PlayerSprite.flip_h = false

	if self.movement_input_vector:
		$PlayerSprite.play("player_move")
	else:
		$PlayerSprite.play("player_idle")


func _die():
	#code for dying
	queue_free()


# Called when the node enters the scene tree for the first time.
func _ready():
	self.paused = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	handle_input()
	animate()
	move_and_slide()
