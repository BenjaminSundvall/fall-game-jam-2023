# ***** Credit were credit is due: *********************************************
# https://godotengine.org/article/multiplayer-in-godot-4-0-scene-replication/
# ******************************************************************************

# player_input.gd
extends Node2D

# Synchronized property.
@export var walk_direction := Vector2(0,0)
@export var aim_point := Vector2(0,0)

var player

const CONTROLLER_CROSSHAIR_DIST = 200

enum InputMode {KEYBOARD, CONTROLLER}
@export var input_mode = InputMode.KEYBOARD

signal pressed_interact
signal pressed_dodge
signal pressed_attack

func _ready():
	player = $".."

func _input(event):	
	if player.player_client_id != multiplayer.get_unique_id():
		return
		
	walk_direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown").normalized()
	
	if input_mode == InputMode.CONTROLLER:	
		var aim_dir = Input.get_vector("AimLeft", "AimRight", "AimUp", "AimDown")
		if aim_dir:
			aim_point = CONTROLLER_CROSSHAIR_DIST * aim_dir.normalized()
	else:
		aim_point = get_global_mouse_position() - player.position
		
	if Input.is_action_just_pressed("Interact"):
		pressed_interact.emit()

	if Input.is_action_just_pressed("Dodge"):
		pressed_dodge.emit()

	if Input.is_action_just_pressed("Attack"):
		pressed_attack.emit()


