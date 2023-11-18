extends CharacterBody2D

enum InputMode {KEYBOARD, CONTROLLER}

@export var health = 100
@export var speed = 800
@export var acceleration = 8000
var friction = speed / acceleration
@export var input_mode = InputMode.KEYBOARD

const CONTROLLER_CROSSHAIR_DIST = 100

var aim_point = Vector2(CONTROLLER_CROSSHAIR_DIST, 0)
var movement_input_vector = Vector2(0, 0)
var aim_input_vector = Vector2(0, 0)

func handle_input():
	self.movement_input_vector = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	self.aim_input_vector = Input.get_vector("AimLeft", "AimRight", "AimUp", "AimDown")

	# Aim
	if self.input_mode == InputMode.CONTROLLER and aim_input_vector:
		self.aim_point = CONTROLLER_CROSSHAIR_DIST * aim_input_vector.normalized()
	elif self.input_mode == InputMode.KEYBOARD:
		self.aim_point = get_global_mouse_position() - position
	$Crosshair.position = self.aim_point

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


func apply_traction(delta):
	#var traction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	#self.velocity += self.movement_input_vector * acceleration * delta
	self.velocity = self.speed * self.movement_input_vector


func apply_friction(delta):
	self.velocity -= self.velocity * friction * delta

func take_damage(damage):
	health -= damage
	if health <= 0:
		_die()

func play_walking_animation():
	if self.movement_input_vector.x < 0:
		$PlayerSprite.flip_h = true
	elif self.movement_input_vector.x > 0:
		$PlayerSprite.flip_h = false

	if self.movement_input_vector:
		$AnimationPlayer.play("player_move_down")
	else:
		$AnimationPlayer.play("player_idle")

func _die():
	#code for dying
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	handle_input()
	play_walking_animation()
	apply_traction(delta)
	apply_friction(delta)
	move_and_slide()
