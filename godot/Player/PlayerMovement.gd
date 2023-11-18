extends CharacterBody2D

enum InputMode {KEYBOARD, CONTROLLER}

@export var speed = 400
@export var acceleration = 8000
@export var friction = acceleration / speed

@export var input_mode = InputMode.KEYBOARD

func get_input():
	# Interact
	if Input.is_action_just_pressed("Interact"):
		print("Interact")
	
	# Dodge
	if Input.is_action_just_pressed("Dodge"):
		print("Dodge")
	
	# Aim
	var aim_point = Vector2()
	if input_mode == InputMode.CONTROLLER:
		aim_point = 300 * Input.get_vector("AimLeft", "AimRight", "AimUp", "AimDown").normalized()
		if aim_point:
			$Crosshair.position = aim_point
	elif input_mode == InputMode.KEYBOARD:
		aim_point = get_global_mouse_position() - position
		$Crosshair.position = aim_point
		
		# Attacking
	if Input.is_action_just_pressed("Attack"):
		get_node("Weapon").attack(aim_point)


func apply_traction(delta):
	var traction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	self.velocity += traction * acceleration * delta


func apply_friction(delta):
	self.velocity -= self.velocity * friction * delta


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	apply_traction(delta)
	apply_friction(delta)
	move_and_slide()

