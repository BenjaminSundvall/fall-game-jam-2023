extends CharacterBody2D

enum InputMode {KEYBOARD, CONTROLLER}

@export var speed = 400
@export var input_mode = InputMode.KEYBOARD

func get_input():
	var input_direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("Attack"):
		print("Attack")
		
	if Input.is_action_just_pressed("Interact"):
		print("Interact")
	
	var aim_point = Vector2(1, 0)
	if input_mode == InputMode.CONTROLLER:
		aim_point = 300 * Input.get_vector("AimLeft", "AimRight", "AimUp", "AimDown")
		if aim_point:
			$Crosshair.position = aim_point
	elif input_mode == InputMode.KEYBOARD:
		aim_point = get_global_mouse_position() - position
		$Crosshair.position = aim_point


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	move_and_slide()

